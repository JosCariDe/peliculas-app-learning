part of 'get_movie_by_id_bloc.dart';

sealed class GetMovieByIdEvent extends Equatable {
  const GetMovieByIdEvent();

  @override
  List<Object> get props => [];
}

class GetMovieUseCase extends GetMovieByIdEvent {
  final String idMovie;

  const GetMovieUseCase({required this.idMovie});


  @override
  List<Object> get props => [idMovie];
}

class ResetMovieByIdEvent extends GetMovieByIdEvent {}
