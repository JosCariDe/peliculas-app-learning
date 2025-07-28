part of 'get_movie_by_id_bloc.dart';

sealed class GetMovieByIdState extends Equatable {
  const GetMovieByIdState();
  
  @override
  List<Object> get props => [];
}

final class GetMovieByIdInitial extends GetMovieByIdState {}
final class GetMovieByIdLoading extends GetMovieByIdState {}
final class GetMovieByIdSucces extends GetMovieByIdState {
  final Movie movie;

  const GetMovieByIdSucces({required this.movie});

  @override
  List<Object> get props => [movie];
}
final class GetMovieByIdFailure extends GetMovieByIdState {
  final String message;

  const GetMovieByIdFailure({required this.message});

  @override
  List<Object> get props => [message];
}
