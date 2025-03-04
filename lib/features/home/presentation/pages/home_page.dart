import 'package:flutter/material.dart';
import 'package:tafaling/core/widgets/my_bottom_navigation_bar/my_bottom_navigation_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          MyBottomNavigationBar(selectedIndex: 0, onItemTapped: (int a) {}),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text('Home Page'),
            ),
          ),
        ],
      ),
    );
  }
}
