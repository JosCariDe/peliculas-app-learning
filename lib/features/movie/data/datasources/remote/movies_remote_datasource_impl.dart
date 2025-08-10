import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:peliculas_app/config/constants/environment.dart';
import 'package:peliculas_app/core/errors/failure.dart';
import 'package:peliculas_app/features/movie/data/datasources/remote/movies_datasource_remote.dart';
import 'package:peliculas_app/features/movie/data/mappers/movie_mapper.dart';
import 'package:peliculas_app/features/movie/data/model/detail/movie_detail_response.dart';
import 'package:peliculas_app/features/movie/data/model/movieDB/moviedb_response.dart';
import 'package:peliculas_app/features/movie/domain/entities/movie.dart';

class MoviesRemoteDatasourceImpl implements MoviesDatasourceRemote {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-CO',
      },
    ),
  );

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    try {
      //debugPrint('Page DataSource: ${page.toString()}');
      final response = await dio.get(
        '/movie/now_playing',
        queryParameters: {'page': page},
      );
      //debugPrint(response.toString());
      //debugPrint('\nEmpezando a Mapper\n');
      final movieDBResponse = MovieDbResponse.fromJson(response.data);
      //debugPrint('\nPrimer Mapper Realizado\n');

      final List<Movie> movies = movieDBResponse.results
          .where((moviedb) => (moviedb.posterPath != 'no-poster'))
          .map((movie) => MovieMapper.movieDBToEntity(movie))
          .toList();

      //debugPrint('\nSegundo Mapper Realizado\n');

      return movies;
    } catch (e) {
      //debugPrint('Error en el DataSource: ${e.toString()}');
      throw LocalFailure();
    }
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    try {
      final response = await dio.get(
        '/movie/popular',
        queryParameters: {'page': page},
      );
      final movieDBResponse = MovieDbResponse.fromJson(response.data);

      final List<Movie> movies = movieDBResponse.results
          .where((moviedb) => (moviedb.posterPath != 'no-poster'))
          .map((movie) => MovieMapper.movieDBToEntity(movie))
          .toList();

      return movies;
    } catch (e) {
      throw RemoteFailure();
    }
  }

  @override
  Future<Movie> getMovieById(String id) async {
    try {
      final response = await dio.get('/movie/$id');

      if (response.statusCode != 200) {
        throw Exception('Movie With id: $id not found');
      }

      debugPrint(
        'Llamado a la api desde el dataSource con la movie con id de $id',
      );

      final movieDetailDBResponse = MovieDetailResponse.fromJson(response.data);

      final Movie movie = MovieMapper.movieDetailDBToEntity(
        movieDetailDBResponse,
      );
      return movie;
    } catch (e) {
      debugPrint(
        'Error en el metodo del dataSource de buscar Movie By Id: $id, error : ${e.toString()}',
      );
      throw RemoteFailure();
    }
  }

  @override
  Future<List<Movie>> searchMovie(String query) async {
    try {
      final response = await dio.get(
        '/search/movie',
        queryParameters: {'query': query},
      );

      debugPrint('Llamado a la api desde el dataSource con query de busqueda');

      final movieDetailDBResponse = MovieDbResponse.fromJson(response.data);

      final List<Movie> movies = movieDetailDBResponse.results
          .map((movie) => MovieMapper.movieDBToEntity(movie))
          .toList();
      return movies;
    } catch (e) {
      debugPrint(
        'Error en el metodo del dataSource de buscar Mobie  error : ${e.toString()}',
      );
      throw RemoteFailure();
    }
  }
}
