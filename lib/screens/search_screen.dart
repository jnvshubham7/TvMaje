import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movie_app/screens/details_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List searchResults = [];
  TextEditingController _searchController = TextEditingController();

  void searchMovies(String query) async {
    final response = await http
        .get(Uri.parse('https://api.tvmaze.com/search/shows?q=$query'));
    if (response.statusCode == 200) {
      setState(() {
        searchResults = jsonDecode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              controller: _searchController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search for movies, shows, etc...',
                hintStyle: TextStyle(color: Colors.grey[600]),
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, color: Colors.grey[600]),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            searchResults = [];
                          });
                        },
                      )
                    : null,
                contentPadding: EdgeInsets.symmetric(vertical: 15),
              ),
              onChanged: (query) {
                if (query.isNotEmpty) {
                  searchMovies(query);
                } else {
                  setState(() {
                    searchResults = [];
                  });
                }
              },
            )),
      ),
      body: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          var movie = searchResults[index]['show'];
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Card(
              color: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 5,
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    movie['image'] != null
                        ? movie['image']['medium']
                        : 'https://via.placeholder.com/150',
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  movie['name'],
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  movie['summary'] != null
                      ? movie['summary']
                              .replaceAll(RegExp(r'<[^>]*>'), '')
                              .substring(
                                  0,
                                  movie['summary']!
                                              .replaceAll(
                                                  RegExp(r'<[^>]*>'), '')
                                              .length <
                                          60
                                      ? movie['summary']!
                                          .replaceAll(RegExp(r'<[^>]*>'), '')
                                          .length
                                      : 60) +
                          '...'
                      : 'No summary available',
                  style: TextStyle(color: Colors.grey),
                ),

//                 The provided Dart code snippet is part of a Flutter widget, 
//specifically a Text widget used as a subtitle within a larger UI component. 
//This widget displays a summary of a movie, with some additional formatting 
//and constraints applied to the text.=
// The Text widget's content is determined by checking if the movie['summary']
// field is not null. If the summary exists, it undergoes a series of transformations. 
//First, any HTML tags within the summary are removed using the replaceAll method 
//with a regular expression (RegExp(r'<[^>]*>')). This ensures that only plain text 
//is displayed, stripping out any HTML formatting.

// Next, the code checks the length of the cleaned summary text. If the length is 
//less than 60 characters, the entire summary is used. Otherwise, only the first 60 
//characters are taken. This is achieved using the substring method, which extracts a
// portion of the string from the start up to the specified length. The extracted text
// is then concatenated with an ellipsis ('...') to indicate that the summary has been truncated.

// If the movie['summary'] field is null, the text "No summary available" is displayed 
//instead. This provides a fallback message for cases where the summary data is missing.

// Finally, the Text widget is styled with a TextStyle that sets the text color to grey 
//(Colors.grey). This styling ensures that the subtitle text visually aligns with the 
//design specifications of the application.
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => DetailsScreen(movie: movie),
                  ));
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
