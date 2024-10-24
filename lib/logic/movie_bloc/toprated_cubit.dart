
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/movie_model.dart';
import 'movie_state.dart';

class TopRatedCubit extends Cubit<MovieState> {
  final Dio _dio;

  TopRatedCubit(this._dio) : super(TopRatedLoadingState());

  Future<void> fetchTopRatedMovies() async {
    emit(TopRatedLoadingState());
    try {
      final response = await _dio.get('https://api.themoviedb.org/3/movie/top_rated?api_key=87903828b97a85b50c60fb3bbd960c55');

      if (response.statusCode == 200) {
        final movieResponse = MovieResponse.fromJson(response.data);
        emit(TopRatedSuccessState(movieResponse));
      } else {
        emit(TopRatedErrorState("Failed to load data"));
      }
    } catch (error) {
      emit(TopRatedErrorState(error.toString()));
    }
  }
}