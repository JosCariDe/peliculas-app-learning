
import 'package:peliculas_app/features/movie/domain/entities/movie.dart';

abstract class MoviesDatasourceRemote {

  Future<List<Movie>> getNowPlaying({int page = 1});

}