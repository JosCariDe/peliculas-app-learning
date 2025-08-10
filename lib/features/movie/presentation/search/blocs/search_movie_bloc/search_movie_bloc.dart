import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_app/features/movie/domain/cases_uses/search_movie_use_case.dart';
import 'package:peliculas_app/features/movie/domain/entities/movie.dart';
import 'package:peliculas_app/features/movie/presentation/search/debounce/event_transformer.dart';
import 'package:stream_transform/stream_transform.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchMovieUseCase searchMovieUseCase;
  SearchMovieBloc(this.searchMovieUseCase) : super(SearchMovieInitial()) {
    on<SearchMovieImplEvent>(
      _onQueryChanged,
      transformer: debounce(const Duration(milliseconds: 300)),
    );
    on<SearchClearedEvent>((event, emit) => emit(SearchMovieInitial()));
  }

  Future<void> _onQueryChanged(
    SearchMovieImplEvent event,
    Emitter<SearchMovieState> emit,
  ) async {
    final q = event.query.trim();
    if (q.isEmpty) {
      emit(SearchMovieInitial());
      return;
    }

    emit(SearchMovieLoading());

    try {
      final resultsMoviesSearch = await searchMovieUseCase(event.query);
      resultsMoviesSearch.fold(
        (failure) {
          debugPrint('Error bloc SearchMovie: ${failure.toString()}');
          emit(
            SearchMovieError(
              message:
                  'Errro al llamar al caso de uso de searchMovie desde el bloc',
            ),
          );
        },
        (listMovies) {
          emit(SearchMovieSuccess(moviesResultSearch: listMovies));
        },
      );
    } catch (e) {
      throw Exception('Error en el bloc desde el bloque try Catch');
    }
  }
}
