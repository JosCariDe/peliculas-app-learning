part of 'get_now_movies_bloc.dart';

@immutable
sealed class GetNowMoviesEvent {}

class GetAllMovies extends GetNowMoviesEvent{}
class LoadNextPage extends GetNowMoviesEvent{}
