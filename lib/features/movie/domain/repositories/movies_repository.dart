import 'package:dartz/dartz.dart';
import 'package:peliculas_app/core/errors/failure.dart';
import 'package:peliculas_app/features/movie/domain/entities/movie.dart';

abstract class MoviesRepository {

  Future<Either<Failure, List<Movie>>> getNowPlaying({ int page = 1 });
  Future<Either<Failure, List<Movie>>> getPopular({ int page = 1 });

}
