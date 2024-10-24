import '../../models/movie_model.dart';

abstract class MovieState {}

class NowPlayingInitialState extends MovieState {}
class NowPlayingLoadingState extends MovieState {}
class NowPlayingSuccessState extends MovieState {
  final MovieResponse nowPlayingResponse;
  NowPlayingSuccessState(this.nowPlayingResponse);
}
class NowPlayingErrorState extends MovieState {
  final String message;
  NowPlayingErrorState(this.message);
}

// Popular Movies States
class PopularLoadingState extends MovieState {}
class PopularSuccessState extends MovieState {
  final MovieResponse popularResponse;
  PopularSuccessState(this.popularResponse);
}
class PopularErrorState extends MovieState {
  final String message;
  PopularErrorState(this.message);
}

// Top-Rated Movies States
class TopRatedLoadingState extends MovieState {}
class TopRatedSuccessState extends MovieState {
  final MovieResponse topRatedResponse;
  TopRatedSuccessState(this.topRatedResponse);
}
class TopRatedErrorState extends MovieState {
  final String message;
  TopRatedErrorState(this.message);
}
