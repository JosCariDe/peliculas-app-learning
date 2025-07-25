import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_app/config/constants/environment.dart';
import 'package:peliculas_app/core/errors/failure.dart';
import 'package:peliculas_app/features/movie/data/datasources/remote/movies_datasource_remote.dart';
import 'package:peliculas_app/features/movie/data/mappers/movie_mapper.dart';
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
        queryParameters: {
          'page': page,
        },
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
        queryParameters: {
          'page': page,
        },
      );
      final movieDBResponse = MovieDbResponse.fromJson(response.data);

      final List<Movie> movies = movieDBResponse.results
          .where((moviedb) => (moviedb.posterPath != 'no-poster'))
          .map((movie) => MovieMapper.movieDBToEntity(movie))
          .toList();

      return movies;
    } catch (e) {
      throw LocalFailure();
    }
  }
}
