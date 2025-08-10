
import 'package:peliculas_app/features/movie/domain/entities/movie.dart';

abstract class MoviesDatasourceRemote {

  Future<List<Movie>> getNowPlaying({int page = 1});
  Future<List<Movie>> getPopular({int page = 1});
  Future<Movie> getMovieById(String id);
  Future<List<Movie>> searchMovie(String query);
}
