part of 'get_popular_movies_bloc.dart';

sealed class GetPopularMoviesEvent extends Equatable {
  const GetPopularMoviesEvent();

  @override
  List<Object> get props => [];
}

class GetAllMoviesPopular extends GetPopularMoviesBloc{
  GetAllMoviesPopular({required super.getPopularUseCase});
}
class LoadNextPagePopular extends GetPopularMoviesBloc{
  LoadNextPagePopular({required super.getPopularUseCase});
}
