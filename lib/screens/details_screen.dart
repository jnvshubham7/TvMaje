
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
