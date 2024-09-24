import 'package:flutter/material.dart';
import 'package:movie_app/screens/splash_screen.dart'; 

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
      ),
      theme: ThemeData(
        primarySwatch: Colors.red, 
      ),
      home: SplashScreen(),
    );
  }
}
