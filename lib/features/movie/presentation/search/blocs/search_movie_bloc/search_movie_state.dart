part of 'search_movie_bloc.dart';

sealed class SearchMovieState extends Equatable {
  const SearchMovieState();
  
  @override
  List<Object> get props => [];
}

final class SearchMovieInitial extends SearchMovieState {}
final class SearchMovieLoading extends SearchMovieState {}
//?
final class SearchMovieSuccess extends SearchMovieState {
  final List<Movie> moviesResultSearch;

  const SearchMovieSuccess({required this.moviesResultSearch});

  @override
  List<Object> get props => [moviesResultSearch];
}
final class SearchMovieError extends SearchMovieState {
  final String message;

  const SearchMovieError({required this.message});

  @override
  List<Object> get props => [message];
}
