import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:peliculas_app/features/movie/domain/cases_uses/get_now_playing_use_case.dart';
import 'package:peliculas_app/features/movie/domain/entities/movie.dart';

part 'get_now_movies_event.dart';
part 'get_now_movies_state.dart';

class GetNowMoviesBloc extends Bloc<GetNowMoviesEvent, GetNowMoviesState> {

  final GetNowPlayingUseCase getNowPlayingUseCase;

  GetNowMoviesBloc({required this.getNowPlayingUseCase}) : super(GetNowMoviesInitial()) {
    on<GetNowMoviesEvent>(_getNowMoviesEvent);
  }

  List<Movie>? get currentMovies {
    final currentState = state;
    if (currentState is GetNowMoviesSuccess) {
      return currentState.movies;
    }
    return null;
  }

  FutureOr<void> _getNowMoviesEvent(
    GetNowMoviesEvent event,
    Emitter<GetNowMoviesState> emit,  
  ) async {
    
    final currentState = state;

    if (currentState is GetNowMoviesSuccess) return;

    if (currentState is GetNowMoviesInitial) {
      emit(GetNowMoviesLoading());
      final resultUseCase = await getNowPlayingUseCase();

      return resultUseCase.fold(
        (failure) => emit(
          GetNowMoviesFailure(
            message: 'Error al usar el caso de uso de GetNowMovies',
          ),
        ),
        (listMovies) => GetNowMoviesSuccess(movies: listMovies),
      );
    }
  }
}
