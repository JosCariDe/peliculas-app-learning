part of 'get_now_movies_bloc.dart';

@immutable
sealed class GetNowMoviesState {}


final class GetNowMoviesInitial extends GetNowMoviesState {

  

}
final class GetNowMoviesLoading extends GetNowMoviesState {}
final class GetNowMoviesSuccess extends GetNowMoviesState {

  final List<Movie> movies;
  final List<Movie>? slideMoovie;

  GetNowMoviesSuccess({required this.movies, this.slideMoovie});

}
final class GetNowMoviesFailure extends GetNowMoviesState {
  final String message;

  GetNowMoviesFailure({required this.message});
}
