import 'package:flutter/material.dart';

class AppBarDrawerIcon extends StatefulWidget {
  const AppBarDrawerIcon({super.key});

  @override
  State<AppBarDrawerIcon> createState() => _AppBarDrawerIconState();
}

class _AppBarDrawerIconState extends State<AppBarDrawerIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          if (_controller.isDismissed) {
            _controller.forward();
          } else {
            _controller.reverse();
          }
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animation,
        ));
  }
}
