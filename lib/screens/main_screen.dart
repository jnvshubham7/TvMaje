import 'package:flutter/material.dart';
import 'package:movie_app/screens/home_screen.dart';
import 'package:movie_app/screens/search_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  PageController _pageController = PageController();
  // why PageController is used here?
  // The PageController is used to control the PageView widget.
  // It allows us to animate the PageView to a specific page.

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    SearchScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      // duration: Duration(milliseconds: 300) is used to set the duration of the animation.
      // curve: Curves.easeInOut is used to set the curve of the animation.
    });
    // why _pageController.animateToPage() is used here?
    // The _pageController.animateToPage() method is used to animate the PageView to a
    //specific page.
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _widgetOptions,
        physics: BouncingScrollPhysics(),
        // why BouncingScrollPhysics() is used here?
        // The BouncingScrollPhysics() is used to create a scroll physics that bounce
        // the scroll when it reaches the edge of the content area.
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black,
        onTap: _onItemTapped,
      ),
      backgroundColor: Colors.black,
    );
  }
}
