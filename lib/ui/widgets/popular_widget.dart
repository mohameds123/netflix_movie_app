import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/movie_bloc/movie_state.dart';
import '../../logic/movie_bloc/popular_cubit.dart';
import '../screens/details_screen.dart';


class PopularWidget extends StatelessWidget {
  const PopularWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularCubit, MovieState>(
      builder: (context, state) {
        if (state is PopularLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PopularSuccessState) {
          final movies = state.popularResponse.results;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  "Popular on Netflix",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  itemCount: movies.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(movieId: movie.id),
                            ),
                          );                        },
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                          width: 103,
                          fit: BoxFit.cover,
                          height: 161,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else if (state is PopularErrorState) {
          return Center(
            child: Text(
              'Error: ${state.message}',
              style: const TextStyle(color: Colors.white),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
