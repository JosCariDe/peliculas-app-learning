part of 'search_movie_bloc.dart';

sealed class SearchMovieEvent extends Equatable {
  const SearchMovieEvent();

  @override
  List<Object> get props => [];
}

class SearchMovieImplEvent extends SearchMovieEvent {
  final String query;

  const SearchMovieImplEvent({required this.query});
  @override
  List<Object> get props => [query];
}

class SearchClearedEvent extends SearchMovieEvent {
  @override
  List<Object> get props => [];
}


