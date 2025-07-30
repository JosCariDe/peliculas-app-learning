part of 'get_actors_bloc.dart';

sealed class GetActorsState extends Equatable {
  const GetActorsState();
  
  @override
  List<Object> get props => [];
}

final class GetActorsInitial extends GetActorsState {}
final class GetActorsLoading extends GetActorsState {}
// ?
final class GetActorsSuccess extends GetActorsState {
  final List<Actor> actors;

  const GetActorsSuccess({required this.actors});

  @override
  List<Object> get props => [actors];
}
// !
final class GetActorsFailure extends GetActorsState {
  final String message;

  const GetActorsFailure({required this.message});

  @override
  List<Object> get props => [message];
}

