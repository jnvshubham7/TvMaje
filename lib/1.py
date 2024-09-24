import os

# Define the folder structure
folders = [
    "lib",
    "lib/screens",
]

# Create folder structure
for folder in folders:
    if not os.path.exists(folder):
        os.makedirs(folder)

# Define the content for each file
main_content = """ 
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData(
        primarySwatch: Colors.red, // Netflix-like theme
      ),
      home: SplashScreen(),
    );
  }
}
"""

splash_screen_content = """
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => MainScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/splash_image.png'), // Add your splash image here
      ),
    );
  }
}
"""

main_screen_content = """
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    SearchScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
"""

home_screen_content = """
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
      appBar: AppBar(
        title: Text('Movies'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => SearchScreen()));
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          var movie = movies[index]['show'];
          return ListTile(
            leading: Image.network(movie['image'] != null ? movie['image']['medium'] : 'https://via.placeholder.com/150'),
            title: Text(movie['name']),
            subtitle: Text(movie['summary'] != null ? movie['summary'].replaceAll(RegExp(r'<[^>]*>'), '') : 'No summary available'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => DetailsScreen(movie: movie),
              ));
            },
          );
        },
      ),
    );
  }
}
"""

search_screen_content = """
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List searchResults = [];
  TextEditingController _searchController = TextEditingController();

  void searchMovies(String query) async {
    final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=$query'));
    if (response.statusCode == 200) {
      setState(() {
        searchResults = jsonDecode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search Movies...',
          ),
          onSubmitted: searchMovies,
        ),
      ),
      body: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          var movie = searchResults[index]['show'];
          return ListTile(
            leading: Image.network(movie['image'] != null ? movie['image']['medium'] : 'https://via.placeholder.com/150'),
            title: Text(movie['name']),
            subtitle: Text(movie['summary'] != null ? movie['summary'].replaceAll(RegExp(r'<[^>]*>'), '') : 'No summary available'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => DetailsScreen(movie: movie),
              ));
            },
          );
        },
      ),
    );
  }
}
"""

details_screen_content = """
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final Map movie;

  DetailsScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie['name'])),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            movie['image'] != null
                ? Image.network(movie['image']['medium'])
                : Image.network('https://via.placeholder.com/300'),
            SizedBox(height: 16),
            Text(movie['name'], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text(movie['summary'] != null ? movie['summary'].replaceAll(RegExp(r'<[^>]*>'), '') : 'No summary available'),
            // Add more details if needed (genres, rating, etc.)
          ],
        ),
      ),
    );
  }
}
"""

# Write content to files
with open('lib/main.dart', 'w') as f:
    f.write(main_content)

with open('lib/screens/splash_screen.dart', 'w') as f:
    f.write(splash_screen_content)

with open('lib/screens/main_screen.dart', 'w') as f:
    f.write(main_screen_content)

with open('lib/screens/home_screen.dart', 'w') as f:
    f.write(home_screen_content)

with open('lib/screens/search_screen.dart', 'w') as f:
    f.write(search_screen_content)

with open('lib/screens/details_screen.dart', 'w') as f:
    f.write(details_screen_content)

print("Flutter project files created successfully.")
