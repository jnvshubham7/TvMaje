import 'package:flutter/material.dart';
import 'dart:async';

import 'package:movie_app/screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // why with SingleTickerProviderStateMixin?
  // The SingleTickerProviderStateMixin is used to provide a TickerProvider
  //for the AnimationController.

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // why late keyword is used here?
  // The late keyword is used to tell the Dart compiler
  //that the variable will be initialized later.

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _animationController.forward();

    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => MainScreen()),
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: Colors.black,
          ),
          FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/splash_image.png'),
                      fit: BoxFit.cover,
                      // why BoxFit.cover?
                      // The BoxFit.cover is used to scale the image
                      // uniformly (maintaining the image's aspect ratio)
                      // so that both dimensions (width and height) of the image
                      // will be equal to or larger than the corresponding dimension of the box.
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  "TvMaje",
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    fontFamily: 'Roboto',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
