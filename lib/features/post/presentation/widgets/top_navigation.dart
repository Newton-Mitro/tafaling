import 'package:flutter/material.dart';
import 'package:tafaling/configs/routes/route_name.dart';

class TopNavigation extends StatelessWidget {
  const TopNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: 35,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.search),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(
                context,
                RoutesName.homePage,
              );
            },
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              "For You",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
