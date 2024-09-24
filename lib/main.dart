import 'package:flutter/material.dart';
import 'package:movie_app/screens/splash_screen.dart'; 

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
