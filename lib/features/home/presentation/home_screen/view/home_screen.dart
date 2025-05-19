import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/core/extensions/app_context.dart';
import 'package:tafaling/features/home/presentation/home_screen/bloc/home_screen_bloc.dart';
import 'package:tafaling/features/post/presentation/views/create_post_screen/view/create_post_screen.dart';
import 'package:tafaling/features/post/presentation/views/posts_screen/view/posts_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _fabAnimationController;
  late AnimationController _borderRadiusAnimationController;
  late Animation<double> fabAnimation;
  late Animation<double> borderRadiusAnimation;
  late CurvedAnimation fabCurve;
  late CurvedAnimation borderRadiusCurve;
  late AnimationController _hideBottomBarAnimationController;

  final tabItems = [
    {'icon': Icons.home, 'label': 'Home'},
    {'icon': Icons.group, 'label': 'Friends'},
    {'icon': Icons.mail, 'label': 'Inbox'},
    {'icon': Icons.person, 'label': 'Profile'},
  ];

  @override
  void initState() {
    super.initState();

    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _borderRadiusAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    fabCurve = CurvedAnimation(
      parent: _fabAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
    borderRadiusCurve = CurvedAnimation(
      parent: _borderRadiusAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );

    fabAnimation = Tween<double>(begin: 0, end: 1).animate(fabCurve);
    borderRadiusAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(borderRadiusCurve);

    _hideBottomBarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    Future.delayed(const Duration(seconds: 1), () {
      _fabAnimationController.forward();
      _borderRadiusAnimationController.forward();
    });
  }

  bool onScrollNotification(ScrollNotification notification) {
    if (notification is UserScrollNotification &&
        notification.metrics.axis == Axis.vertical) {
      switch (notification.direction) {
        case ScrollDirection.forward:
          _hideBottomBarAnimationController.reverse();
          _fabAnimationController.forward(from: 0);
          break;
        case ScrollDirection.reverse:
          _hideBottomBarAnimationController.forward();
          _fabAnimationController.reverse(from: 1);
          break;
        case ScrollDirection.idle:
          break;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeScreenBloc(),
      child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: _getScreen(state.selectedIndex),
            floatingActionButton: ScaleTransition(
              scale: fabAnimation,
              child: FloatingActionButton(
                shape: const CircleBorder(),
                elevation: 6,
                backgroundColor: context.theme.colorScheme.primary,
                onPressed: () {
                  // Add your FAB logic here
                },
                child: Icon(
                  Icons.add,
                  size: 28,
                  color: context.theme.colorScheme.onPrimary,
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: AnimatedBottomNavigationBar.builder(
              itemCount: tabItems.length,
              tabBuilder: (int index, bool isActive) {
                final color = isActive ? Colors.blueAccent : Colors.grey;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      tabItems[index]['icon'] as IconData,
                      size: 24,
                      color: color,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tabItems[index]['label'] as String,
                      style: TextStyle(color: color, fontSize: 12),
                    ),
                  ],
                );
              },
              backgroundColor: context.theme.colorScheme.primary,
              activeIndex: state.selectedIndex,
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.softEdge,
              leftCornerRadius: 32,
              rightCornerRadius: 32,
              onTap: (index) {
                context.read<HomeScreenBloc>().add(TabChanged(index));
              },
            ),
          );
        },
      ),
    );
  }

  Widget _getScreen(int index) {
    final screens = [
      const PostsScreen(),
      const Center(child: Text('Friends')),
      const Center(child: Text('Inbox')),
      const Center(child: Text('Profile')),
    ];
    return screens[index];
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    _borderRadiusAnimationController.dispose();
    _hideBottomBarAnimationController.dispose();
    super.dispose();
  }
}
