import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/core/extensions/app_context.dart';
import 'package:tafaling/core/injection.dart';
import 'package:tafaling/features/auth/presentation/views/bloc/auth_bloc/auth_bloc.dart';
import 'package:tafaling/features/home/presentation/home_screen/bloc/home_screen_bloc.dart';
import 'package:tafaling/features/home/presentation/widgets/bottom_sheet.dart';
import 'package:tafaling/features/post/presentation/views/post_comment_screen/bloc/post_comment_list_bloc/post_comment_list_bloc.dart';
import 'package:tafaling/features/post/presentation/views/posts_screen/view/posts_screen.dart';
import 'package:tafaling/features/user/presentation/friends_screen/bloc/friends_bloc.dart';
import 'package:tafaling/features/user/presentation/friends_screen/view/friends_screen.dart';
import 'package:tafaling/features/user/presentation/my_profile_screen/view/my_profile_screen.dart';
import 'package:tafaling/routes/app_route_name.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController _fabAnimationController;
  late final AnimationController _borderRadiusAnimationController;
  late final AnimationController _hideBottomBarAnimationController;

  late final Animation<double> fabAnimation;
  late final Animation<double> borderRadiusAnimation;

  late final CurvedAnimation fabCurve;
  late final CurvedAnimation borderRadiusCurve;

  final List<Map<String, Object>> tabItems = [
    {'icon': Icons.home, 'label': 'Home'},
    {'icon': Icons.group, 'label': 'Friends'},
    {'icon': Icons.mail, 'label': 'Inbox'},
    {'icon': Icons.person, 'label': 'Profile'},
  ];

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthUserCheck());

    _fabAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _borderRadiusAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _hideBottomBarAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
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

    Future.delayed(const Duration(milliseconds: 500), () {
      _fabAnimationController.forward();
      _borderRadiusAnimationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<FriendsBloc>()),
        BlocProvider(create: (_) => sl<PostCommentListBloc>()),
        BlocProvider(create: (_) => HomeScreenBloc()),
      ],

      child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
        builder: (context, homeScreenState) {
          return BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState) {
              return Scaffold(
                body: BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is UnAuthenticated) {
                      context.read<HomeScreenBloc>().add(
                        TabChanged(
                          homeScreenState.selectedIndex > 1
                              ? 0
                              : homeScreenState.selectedIndex,
                        ),
                      );
                    }
                  },
                  child: _getScreen(
                    homeScreenState.selectedIndex,
                    authState,
                    homeScreenState,
                  ),
                ),
                floatingActionButton: ScaleTransition(
                  scale: fabAnimation,
                  child: FloatingActionButton(
                    shape: const CircleBorder(),
                    elevation: 6,
                    backgroundColor: context.theme.colorScheme.primary,
                    onPressed: () {
                      if (authState is Authenticated) {
                        Navigator.of(
                          context,
                        ).pushNamed(AppRouteName.cameraPage);
                      } else {
                        showCustomBottomSheet(context);
                      }
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
                  tabBuilder: (index, isActive) {
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
                  activeIndex: homeScreenState.selectedIndex,
                  gapLocation: GapLocation.center,
                  notchSmoothness: NotchSmoothness.softEdge,
                  leftCornerRadius: 32,
                  rightCornerRadius: 32,
                  onTap: (index) {
                    final authState = context.read<AuthBloc>().state;

                    final isAlwaysAllowed = index == 0 || index == 1;
                    final isAuthenticated = authState is Authenticated;

                    if (isAlwaysAllowed || isAuthenticated) {
                      context.read<HomeScreenBloc>().add(TabChanged(index));
                    } else {
                      showCustomBottomSheet(context);
                      context.read<AuthBloc>().add(AuthUserCheck());
                    }
                  },
                  hideAnimationController: _hideBottomBarAnimationController,
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _getScreen(
    int index,
    AuthState authState,
    HomeScreenState homeScreenState,
  ) {
    if (authState is UnAuthenticated && homeScreenState.selectedIndex > 1) {
      showCustomBottomSheet(context);
    }

    final authUser = authState is Authenticated ? authState.authUser : null;

    final screens = [
      const PostsScreen(),
      FriendsScreen(userId: authUser?.user.id ?? 0),
      const Center(child: Text('Inbox')),
      authUser != null
          ? MyProfileScreen()
          : Center(child: CircularProgressIndicator()),
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
