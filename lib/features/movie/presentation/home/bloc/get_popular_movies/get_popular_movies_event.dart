part of 'get_popular_movies_bloc.dart';

sealed class GetPopularMoviesEvent extends Equatable {
  const GetPopularMoviesEvent();

  @override
  List<Object> get props => [];
}

class GetAllMoviesPopular extends GetPopularMoviesEvent{}
class LoadNextPagePopular extends GetPopularMoviesEvent{}
