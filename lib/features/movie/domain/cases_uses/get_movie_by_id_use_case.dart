import 'package:dartz/dartz.dart';
import 'package:peliculas_app/core/errors/failure.dart';
import 'package:peliculas_app/features/movie/domain/entities/movie.dart';
import 'package:peliculas_app/features/movie/domain/repositories/movies_repository.dart';

class GetMovieByIdUseCase {

  final MoviesRepository repository;

  GetMovieByIdUseCase({required this.repository});

  Future<Either<Failure, Movie>> call(String id) {
    return repository.getMovieById(id);
  }

}