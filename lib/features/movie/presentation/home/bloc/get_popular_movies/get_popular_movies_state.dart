part of 'get_popular_movies_bloc.dart';

sealed class GetPopularMoviesState extends Equatable {
  const GetPopularMoviesState();
  
  @override
  List<Object> get props => [];
}

final class GetPopularMoviesInitial extends GetPopularMoviesState {}
final class GetPopularMoviesLoading extends GetPopularMoviesState {}
final class GetPopularMoviesSuccess extends GetPopularMoviesState {
  final List<Movie> movies;

  const GetPopularMoviesSuccess({required this.movies});

  @override
  List<Object> get props => [movies];
}
final class GetPopularMoviesFailure extends GetPopularMoviesState {
  final String message;

  const GetPopularMoviesFailure({required this.message});

  @override
  List<Object> get props => [message];

}
