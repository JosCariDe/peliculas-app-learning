import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:peliculas_app/features/movie/domain/cases_uses/get_movie_by_id_use_case.dart';
import 'package:peliculas_app/features/movie/domain/entities/movie.dart';

part 'get_movie_by_id_event.dart';
part 'get_movie_by_id_state.dart';

class GetMovieByIdBloc extends Bloc<GetMovieByIdEvent, GetMovieByIdState> {
  final GetMovieByIdUseCase getMovieUseCase;

  GetMovieByIdBloc({required this.getMovieUseCase})
    : super(GetMovieByIdInitial()) {
    on<GetMovieUseCase>(_onGetMovieByIdEvent);
    on<ResetMovieByIdEvent>((event, emit) {
      emit(GetMovieByIdInitial());
    });
  }

  Future<void> _onGetMovieByIdEvent(
    GetMovieUseCase event,
    Emitter<GetMovieByIdState> emit,
  ) async {
    final currentState =state;
    if (currentState is GetMovieByIdSucces){
      return;
    }

    debugPrint('Llamada al evento ByID: ${event.idMovie}');

    // Remover esta condición que bloquea la recarga
    // if (currenState is GetMovieByIdSucces) return;


    final responseCaseUse = await getMovieUseCase(event.idMovie);
    
    responseCaseUse.fold(
      (failure) => emit(
        GetMovieByIdFailure(
          message:
              'Error al usar el caso de uso de GetMovieById desde el bloc.',
        ),
      ),
      (movie) => emit(GetMovieByIdSucces(movie: movie)),
    );
  }
}
