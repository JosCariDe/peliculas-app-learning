import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:peliculas_app/features/credit/domain/case_use/get_actors_case_use.dart';
import 'package:peliculas_app/features/credit/domain/entities/actor.dart';

part 'get_actors_event.dart';
part 'get_actors_state.dart';

class GetActorsBloc extends Bloc<GetActorsEvent, GetActorsState> {
  final GetActorsCaseUse getActorsUseCase;
  GetActorsBloc({required this.getActorsUseCase}) : super(GetActorsInitial()) {
    on<GetActorsUseCaseEvent>(_onGetActorsUseCaseEvent);
  }

  Future<void> _onGetActorsUseCaseEvent(GetActorsUseCaseEvent event, Emitter<GetActorsState> emit) async{
    final currentState = state;

    if (currentState is GetActorsSuccess) return;

    emit(GetActorsLoading());

    final responseCaseUse = await getActorsUseCase(event.idMovie);

    responseCaseUse.fold(
      (failure) => emit(
        GetActorsFailure(
          message: 'Error al usar el caso de uso de GetActors desde el bloc.',
        ),
      ),
      (actors) => emit(GetActorsSuccess(actors: actors)),
    );
  }
}
