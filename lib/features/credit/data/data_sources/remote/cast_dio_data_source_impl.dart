import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_app/config/constants/environment.dart';
import 'package:peliculas_app/core/errors/failure.dart';
import 'package:peliculas_app/features/credit/data/data_sources/remote/cast_remote_data_source.dart';
import 'package:peliculas_app/features/credit/data/mappers/cast_mapper.dart';
import 'package:peliculas_app/features/credit/data/models/cast_response.dart';
import 'package:peliculas_app/features/credit/domain/entities/actor.dart';

class CastDioDataSourceImpl extends CastRemoteDataSource {
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
  Future<List<Actor>> getCastByIdMovie(int id)async {
    try {
      final response = await dio.get('/movie/$id/credits');

      if (response.statusCode != 200) throw Exception('Movie With Id: $id not found');

      final CastResponse castReponse = CastResponse.fromJson(response.data);

      final List<Actor> actorList = castReponse.cast.map((actor) => CastMapper.castOnlyDBToActor(actor)).toList();

      return actorList;
    } catch (error) {
      debugPrint('Error al usar el dataSource de cast, en el metodo getCastByIdMovie: ${error.toString()}');
      throw RemoteFailure();
    }
  }
}
