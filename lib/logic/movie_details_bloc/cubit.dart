import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:netflix/logic/movie_details_bloc/state.dart';
import '../../models/movie_details_model.dart';


class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final Dio dio;

  MovieDetailsCubit(this.dio) : super(MovieDetailsInitial());

  Future<void> fetchMovieDetails(int movieId) async {
    emit(MovieDetailsLoading());

    try {
      final response = await dio.get('https://api.themoviedb.org/3/movie/$movieId?api_key=87903828b97a85b50c60fb3bbd960c55');

      if (response.statusCode == 200) {
        MovieDetails movieDetails = MovieDetails.fromJson(response.data);
        emit(MovieDetailsLoaded(movieDetails));
      } else {
        emit(MovieDetailsError("Failed to load movie details"));
      }
    } catch (e) {
      emit(MovieDetailsError(e.toString()));
    }
  }
}
