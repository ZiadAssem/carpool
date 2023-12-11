import 'package:carpool/view/routes_updated.dart';
import 'package:flutter/material.dart';

import '../firebase/authentication.dart';
import 'cart.dart';
import 'profile.dart';
import 'deprecated_views/routes.dart'; // Import your Profile page

class BottomNavPage extends StatefulWidget {
  @override
  _BottomNavPageState createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int _currentIndex = 0;
  
  final PageController _pageController = PageController(initialPage: 0);

  final List<Widget> _pages = [
    const RoutesUpdated(),
    const CartPage(),
    ProfilePage(isOnline: Authentication.instance.isOnline,),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildMainBackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: _buildPageView(),
          bottomNavigationBar: _buildBottomNavigationBar(),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      unselectedItemColor: Colors.black,
      selectedItemColor: const Color.fromARGB(255, 142, 15, 6),
      backgroundColor: Colors.white, // Set background color
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
          _pageController.animateToPage(index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut);
        });
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Routes'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }

  Widget _buildPageView() {
    return Container(
      // decoration: _buildMainBackground(),
      child: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _pages,
      ),
    );
  }

  Widget _buildMainBackground() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage("assets/images/car-background.jpg"),
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
