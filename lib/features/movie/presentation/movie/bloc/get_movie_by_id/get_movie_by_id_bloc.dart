import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:peliculas_app/features/movie/domain/cases_uses/get_movie_by_id_use_case.dart';
import 'package:peliculas_app/features/movie/domain/entities/movie.dart';

part 'get_movie_by_id_event.dart';
part 'get_movie_by_id_state.dart';

class GetMovieByIdBloc extends Bloc<GetMovieByIdEvent, GetMovieByIdState> {
  final GetMovieByIdUseCase getMovieUseCase;

  GetMovieByIdBloc({required this.getMovieUseCase})
    : super(GetMovieByIdInitial()) {
    on<GetMovieUseCase>(_onGetMovieByIdEvent);
  }

  Future<void> _onGetMovieByIdEvent(
    GetMovieUseCase event,
    Emitter<GetMovieByIdState> emit,
  ) async {
    final currenState = state;

    if (currenState is GetMovieByIdSucces) return;

    if (currenState is GetMovieByIdInitial) {
      emit(GetMovieByIdLoading());

      final responseCaseUse = await getMovieUseCase(event.idMovie);

      responseCaseUse.fold(
        ((failure) => emit(
          GetMovieByIdFailure(
            message:
                'Error al usar el caso de uso de GetMovieById desde el bloc. ',
          ),
        )),
        (movie) {
          emit(GetMovieByIdSucces(movie: movie));
        },
      );
    }
  }
}
