import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import '../../logic/movie_bloc/nowplaying_cubit.dart';
import '../../logic/movie_bloc/popular_cubit.dart';
import '../../logic/movie_bloc/toprated_cubit.dart';
import '../widgets/now_playing_widget.dart';
import '../widgets/popular_widget.dart';
import '../widgets/top_rated_widget.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NowPlayingCubit(Dio())..fetchNowPlayingMovies()),
        BlocProvider(create: (context) => PopularCubit(Dio())..fetchPopularMovies()),
        BlocProvider(create: (context) => TopRatedCubit(Dio())..fetchTopRatedMovies()),
      ],
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              NowPlayingWidget(),
              SizedBox(height: 32),
              PopularWidget(),
              SizedBox(height: 32),
              TopRatedWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
