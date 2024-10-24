import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/movie_bloc/movie_state.dart';
import '../../logic/movie_bloc/nowplaying_cubit.dart';
import '../screens/details_screen.dart';

class NowPlayingWidget extends StatelessWidget {
  const NowPlayingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NowPlayingCubit, MovieState>(
      builder: (context, state) {
        if (state is NowPlayingLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is NowPlayingSuccessState) {
          final movies = state.nowPlayingResponse.results;

          return SizedBox(
            height: 370,
            child: ListView.builder(
              itemCount: movies.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return Stack(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(movieId: movie.id),
                          ),
                        );
                      },
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                        width: 420,
                        fit: BoxFit.cover,
                        height: 370,
                      ),
                    ),
                    Positioned(
                      top: 340,
                      left: 112,
                      child: Row(
                        children: [
                          Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text("NOW PLAYING", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        } else if (state is NowPlayingErrorState) {
          return Center(child: Text('Failed to load now playing movies: ${state.message}', style: const TextStyle(color: Colors.white)));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
