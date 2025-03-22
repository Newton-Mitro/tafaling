import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/app_configs/routes/route_name.dart';
import 'package:tafaling/core/bloc/app_state_bloc.dart';
import 'package:tafaling/core/constants/constants.dart';
import 'package:tafaling/core/utils/local_storage.dart';
import 'package:tafaling/features/home/presentation/notifier/notifiers.dart';
import 'package:tafaling/features/home/presentation/widgets/home_screen_body.dart';
import 'package:tafaling/features/post/injection.dart';
import 'package:tafaling/features/post/presentation/views/posts_screen/bloc/posts_screen_bloc.dart';
import 'package:tafaling/features/user/data/models/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isBottomSheetOpen = false;

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    final localStorage = sl<LocalStorage>();
    final authUser = await localStorage.getString(Constants.authUserKey);
    if (authUser != null) {
      authUserNotifier.value = UserModel.fromJson(jsonDecode(authUser));
    }

    final accessToken = await localStorage.getString(Constants.accessTokenKey);
    accessTokenNotifier.value = accessToken;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<PostsScreenBloc>()),
        BlocProvider(
          create: (context) => sl<AppStateBloc>()..add(IsAuthenticated()),
        ),
      ],
      child: BlocListener<AppStateBloc, AppStateState>(
        listener: (context, state) {
          if (state is Unauthenticated) {
            Navigator.pushReplacementNamed(context, RoutesName.root);
          }
        },
        child: HomeScreenBody(isBottomSheetOpen: _isBottomSheetOpen),
      ),
    );
  }
}
