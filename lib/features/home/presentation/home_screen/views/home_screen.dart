import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/features/home/presentation/home_screen/bloc/home_screen_bloc.dart';
import 'package:tafaling/features/home/presentation/widgets/home_screen_body.dart';
import 'package:tafaling/features/post/presentation/posts_screen/bloc/posts_screen_bloc.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => serviceLoc<HomeScreenBloc>()),
        BlocProvider(create: (context) => serviceLoc<PostsScreenBloc>()),
      ],
      child: HomeScreenBody(isBottomSheetOpen: _isBottomSheetOpen),
    );
  }
}
