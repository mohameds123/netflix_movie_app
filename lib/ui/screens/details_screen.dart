import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/movie_details_bloc/cubit.dart';
import '../../logic/movie_details_bloc/state.dart';

class DetailsScreen extends StatelessWidget {
  final int movieId;

  const DetailsScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context)=>MovieDetailsCubit(Dio())..fetchMovieDetails(movieId),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
          builder: (context, state) {
            if (state is MovieDetailsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is MovieDetailsLoaded) {
              final movie = state.movieDetails;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      "https://image.tmdb.org/t/p/w500${movie.backdropPath}",
                      width: double.infinity,
                      fit: BoxFit.cover,
                      height: 287,
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        movie.title,
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          Icon(Icons.access_time_outlined, size: 12, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text("${movie.runtime} minutes", style: TextStyle(fontSize: 12, color: Colors.grey)),
                          const SizedBox(width: 16),
                          Icon(Icons.star, size: 12, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text("${movie.voteAverage} (IMDb)", style: TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Container(height: 0.5, width: double.infinity, color: Colors.grey.shade800),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text("Genres:", style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Wrap(
                        spacing: 8,
                        children: movie.genres.map((genre) => Chip(
                          label: Text(genre.name, style: TextStyle(color: Colors.white)),
                          backgroundColor: Colors.grey.shade800,
                        )).toList(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Container(height: 0.5, width: double.infinity, color: Colors.grey.shade800),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text("Description", style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(movie.overview!, style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text("Related Movies", style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 106,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5, // Example count for related movies
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Image.network(
                                "https://image.tmdb.org/t/p/w500${movie.posterPath}", // Replace with actual related movie poster
                                width: 142,
                                fit: BoxFit.fill,
                                height: 106,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is MovieDetailsError) {
              return Center(child: Text(state.message, style: TextStyle(color: Colors.red)));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
