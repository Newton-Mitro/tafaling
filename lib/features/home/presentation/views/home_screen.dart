import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/configs/routes/route_name.dart';
import 'package:tafaling/core/utils/app_context.dart';
import 'package:tafaling/features/home/presentation/states/bloc/home_screen_bloc.dart';
import 'package:tafaling/features/home/presentation/widgets/my_bottom_navigation_bar.dart';
import 'package:tafaling/features/home/presentation/states/notifiers.dart';
import 'package:tafaling/features/home/presentation/views/friends_screen.dart';
import 'package:tafaling/features/home/presentation/views/inbox_screen.dart';
import 'package:tafaling/features/home/presentation/views/post_screen.dart';
import 'package:tafaling/features/post/presentation/states/post_bloc/posts_screen_bloc.dart';
import 'package:tafaling/features/post/presentation/views/posts_screen.dart';
import 'package:tafaling/features/user/presentation/views/my_profile_screen.dart';
import 'package:tafaling/features/user/presentation/views/user_profile_screen.dart';
import 'package:tafaling/injection_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isBottomSheetOpen = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeScreenBloc>(
          create: (context) => servLoc<HomeScreenBloc>(),
        ),
        BlocProvider<PostsScreenBloc>(
          create: (context) => servLoc<PostsScreenBloc>(),
        ),
        BlocProvider<HomeScreenBloc>(
          create: (context) => servLoc<HomeScreenBloc>(),
        ),
      ],
      child: BlocConsumer<HomeScreenBloc, HomeScreenState>(
        listener: (context, state) {
          if (state is GuestState && !_isBottomSheetOpen) {
            _showCustomBottomSheet(context, screenSize);
          }
        },
        builder: (context, state) {
          List<Widget> screens = [
            PostsScreen(),
            FriendsScreen(),
            PostScreen(),
            InboxScreen(),
            UserProfileScreen(userId: state.authUserId),
          ];

          return Scaffold(
            body: ValueListenableBuilder(
              valueListenable: selectedPageNotifier,
              builder: (context, selectedPage, child) {
                return screens.elementAt(selectedPage);
              },
            ),
            bottomNavigationBar: MyBottomNavigationBar(),
          );
        },
      ),
    );
  }

  void _showCustomBottomSheet(BuildContext context, Size screenSize) {
    _isBottomSheetOpen = true;
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: screenSize.height,
          width: screenSize.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                context.theme.colorScheme.primary,
                context.theme.colorScheme.secondary
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context); // Close the bottom sheet
                  },
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Image.asset(
                  'assets/images/brand/logo.png',
                  width: 150,
                ),
              ),
              const SizedBox(height: 50),
              _buildButton(context, 'Login', RoutesName.loginPage, screenSize),
              const SizedBox(height: 10),
              const Text(
                'or',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 10),
              _buildButton(
                  context, 'Register', RoutesName.registerPage, screenSize),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    ).whenComplete(() {
      _isBottomSheetOpen = false;
      // Trigger event after the bottom sheet is dismissed and context is valid
      context.read<PostsScreenBloc>().add(const InitPostsScreenEvent());
    });
  }

  Widget _buildButton(
      BuildContext context, String text, String route, Size screenSize) {
    return SizedBox(
      width: screenSize.width * 0.8,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: context.theme.colorScheme.surface,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        child: Text(
          text,
          style: TextStyle(
              fontSize: 18, color: context.theme.colorScheme.onSurface),
        ),
      ),
    );
  }
}
