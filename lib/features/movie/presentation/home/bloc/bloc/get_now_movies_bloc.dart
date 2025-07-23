import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:peliculas_app/features/movie/domain/cases_uses/get_now_playing_use_case.dart';
import 'package:peliculas_app/features/movie/domain/entities/movie.dart';

part 'get_now_movies_event.dart';
part 'get_now_movies_state.dart';

class GetNowMoviesBloc extends Bloc<GetNowMoviesEvent, GetNowMoviesState> {

  final GetNowPlayingUseCase getNowPlayingUseCase;
  int currenPage = 1;

  GetNowMoviesBloc({required this.getNowPlayingUseCase}) : super(GetNowMoviesInitial()) {
    on<GetAllMovies>(_getNowMoviesEvent);
    on<LoadNextPage>(_loadNextPage);
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
        (listMovies) {
          emit(GetNowMoviesSuccess(movies: listMovies));
          debugPrint(listMovies[0].id.toString());
        },
      );
    }
  }

  FutureOr<void> _loadNextPage(
    GetNowMoviesEvent event,
    Emitter<GetNowMoviesState> emit,  
  ) async {
    
    final currentState = state;
    if (currentState is GetNowMoviesInitial) return _getNowMoviesEvent(event, emit);

    if (currentState is GetNowMoviesSuccess) {
      emit(GetNowMoviesLoading());
      currenPage++;
      final resultUseCase = await getNowPlayingUseCase(page: currenPage);

      return resultUseCase.fold(
        (failure) => emit(
          GetNowMoviesFailure(
            message: 'Error al Pasar a la pagina $currenPage de las movies desde el bloc',
          ),
        ),
        (listMovies) {
          debugPrint('Ultima pelicula, tiene el titulo: ${listMovies[listMovies.length - 1].title}');
          final combinatedMovies = List<Movie>.from(currentState.movies)..addAll(listMovies);
          emit(GetNowMoviesSuccess(movies: combinatedMovies));
          debugPrint(currenPage.toString());
        },
      );
    }
  }
}
