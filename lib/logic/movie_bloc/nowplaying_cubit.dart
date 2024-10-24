import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/movie_model.dart';
import 'movie_state.dart';


class NowPlayingCubit extends Cubit<MovieState> {
  final Dio _dio;

  NowPlayingCubit(this._dio) : super(NowPlayingInitialState());

  Future<void> fetchNowPlayingMovies() async {
    emit(NowPlayingLoadingState());

    try {
      final response = await _dio.get('https://api.themoviedb.org/3/movie/now_playing?api_key=87903828b97a85b50c60fb3bbd960c55');

      if (response.statusCode == 200) {
        final nowPlayingResponse = MovieResponse.fromJson(response.data);
        emit(NowPlayingSuccessState(nowPlayingResponse));
      } else {
        emit(NowPlayingErrorState("Failed to load data"));
      }
    } catch (e) {
      emit(NowPlayingErrorState(e.toString()));
    }
  }
}