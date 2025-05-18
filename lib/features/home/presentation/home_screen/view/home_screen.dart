import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/routes/route_name.dart';
import 'package:tafaling/core/injection.dart';
import 'package:tafaling/features/home/presentation/home_screen/bloc/auth_bloc.dart';
import 'package:tafaling/features/home/presentation/widgets/home_screen_body.dart';
import 'package:tafaling/features/post/presentation/views/posts_screen/bloc/posts_screen_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<PostsScreenBloc>()),
        BlocProvider(create: (context) => sl<AuthBloc>()),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Unauthenticated) {
            Navigator.pushReplacementNamed(context, RoutesName.root);
          }
        },
        child: HomeScreenBody(),
      ),
    );
  }
}
