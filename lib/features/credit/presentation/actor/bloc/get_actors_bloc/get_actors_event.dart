part of 'get_actors_bloc.dart';

sealed class GetActorsEvent extends Equatable {
  const GetActorsEvent();

  @override
  List<Object> get props => [];
}

class GetActorsUseCaseEvent extends GetActorsEvent {
  final int idMovie;

  const GetActorsUseCaseEvent({required this.idMovie});

  @override
  List<Object> get props => [idMovie];
} 
