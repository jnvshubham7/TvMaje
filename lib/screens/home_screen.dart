import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/screens/search_screen.dart';
import 'dart:convert';
import 'details_screen.dart'; // Import your details screen here

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List movies = [];

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  fetchMovies() async {
    final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=all'));
    if (response.statusCode == 200) {
      setState(() {
        movies = jsonDecode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Movies', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => SearchScreen()));
            },
          ),
        ],
      ),
      body: movies.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section for popular movies (mock section)
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text(
                //     "Popular Movies",
                //     style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                //   ),
                // ),
                Expanded(child: buildMovieList()), // Use Expanded to fill available space
                // You can add more sections like "Trending", "Top Rated", etc.
              ],
            ),
    );
  }

  Widget buildMovieList() {
    return Container(
      height: 500, // Adjust the height to accommodate more movies
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns in the grid
          childAspectRatio: 0.7, // Adjust the aspect ratio for better layout
          crossAxisSpacing: 8.0, // Horizontal space between grid items
          mainAxisSpacing: 8.0, // Vertical space between grid items
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          var movie = movies[index]['show'];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => DetailsScreen(movie: movie),
              ));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.grey[800], // Background color for better visibility
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        movie['image'] != null ? movie['image']['medium'] : 'https://via.placeholder.com/150',
                        fit: BoxFit.cover,
                        width: double.infinity, // Set width to fill the container
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      movie['name'],
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow, size: 14),
                        SizedBox(width: 4),
                        Text(
                          movie['rating']['average'] != null ? movie['rating']['average'].toString() : 'N/A',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
