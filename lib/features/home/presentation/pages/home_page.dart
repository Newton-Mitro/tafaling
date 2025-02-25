import 'package:flutter/material.dart';
import 'package:flutter_skeleton/res/widgets/my_tool_bar/custom_app_bar.dart';
import 'package:flutter_skeleton/res/widgets/my_tool_bar/my_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: SafeArea(
        child: MyDrawer(),
      ),
      body: Column(
        children: [
          // MyAppBar(),
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
