
import 'package:dartz/dartz.dart';
import 'package:peliculas_app/core/errors/failure.dart';
import 'package:peliculas_app/features/movie/domain/entities/movie.dart';
import 'package:peliculas_app/features/movie/domain/repositories/movies_repository.dart';

class SearchMovieUseCase {
  final MoviesRepository movieRepository;

  SearchMovieUseCase({required this.movieRepository});

  Future<Either<Failure, List<Movie>>> call(String query) {
    return movieRepository.searchMovie(query);
  }
}