import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_app/features/movie/domain/cases_uses/get_popular_use_case.dart';
import 'package:peliculas_app/features/movie/domain/entities/movie.dart';

part 'get_popular_movies_event.dart';
part 'get_popular_movies_state.dart';

class GetPopularMoviesBloc
    extends Bloc<GetPopularMoviesEvent, GetPopularMoviesState> {
  final GetPopularUseCase getPopularUseCase;
  int currentPage = 1;
  bool _isLoadingNextPage = false;

  GetPopularMoviesBloc({required this.getPopularUseCase})
    : super(GetPopularMoviesInitial()) {
    on<GetAllMoviesPopular>(_getPopularMoviesEven);
    on<LoadNextPagePopular>(_loadNextPagePopulate);
  }

  Future<void> _getPopularMoviesEven(
    GetPopularMoviesEvent event,
    Emitter<GetPopularMoviesState> emit,
  ) async {
    debugPrint('En Popular movies BLoC 2');
    final currentState = state;

    if (currentState is GetPopularMoviesSuccess) return;

    if (currentState is GetPopularMoviesInitial) {
      emit(GetPopularMoviesLoading());
      debugPrint('En Popular movies BLoC 2');
      final resultUseCase = await getPopularUseCase();

      return resultUseCase.fold(
        (failure) => emit(
          GetPopularMoviesFailure(
            message: 'Error al usar el caso de uso de GetPopularMovies',
          ),
        ),
        (listMovies) {
          emit(GetPopularMoviesSuccess(movies: listMovies));
        },
      );
    }
  }

  Future<void> _loadNextPagePopulate(
    GetPopularMoviesEvent event,
    Emitter<GetPopularMoviesState> emit,
  ) async {
    if (_isLoadingNextPage) return;
    final currentState = state;

    if (currentState is GetPopularMoviesInitial) _getPopularMoviesEven(event, emit);

    if (currentState is GetPopularMoviesSuccess) {
      _isLoadingNextPage = true;
      currentPage++;
      final resultUseCase = await getPopularUseCase(page: currentPage);

      return resultUseCase.fold(
        (failure) => emit(
          GetPopularMoviesFailure(
            message: 'Error al usar el caso de uso de GetPopularMovies al cargar una nueva pagina',
          ),
        ),
        (listMovies) async {
          final combinatedMovies = List<Movie>.from(currentState.movies)..addAll(listMovies);
          debugPrint(currentPage.toString());
          emit(GetPopularMoviesSuccess(movies: combinatedMovies));
          _isLoadingNextPage = false;
        },
      );
    }
  }
}
