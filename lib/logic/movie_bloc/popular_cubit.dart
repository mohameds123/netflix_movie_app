import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/movie_model.dart';
import 'movie_state.dart';

class PopularCubit extends Cubit<MovieState> {
  final Dio _dio;

  PopularCubit(this._dio) : super(PopularLoadingState());

  Future<void> fetchPopularMovies() async {
    emit(PopularLoadingState());
    try {
      final response = await _dio.get('https://api.themoviedb.org/3/movie/popular?api_key=87903828b97a85b50c60fb3bbd960c55');

      if (response.statusCode == 200) {
        final movieResponse = MovieResponse.fromJson(response.data);
        emit(PopularSuccessState(movieResponse));
      } else {
        emit(PopularErrorState("Failed to load data"));
      }
    } catch (error) {
      emit(PopularErrorState(error.toString()));
    }
  }
}