import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_app/core/errors/failure.dart';
import 'package:peliculas_app/features/movie/data/datasources/remote/movies_datasource_remote.dart';
import 'package:peliculas_app/features/movie/domain/entities/movie.dart';
import 'package:peliculas_app/features/movie/domain/repositories/movies_repository.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  
  final MoviesDatasourceRemote movieDataSource;

  MoviesRepositoryImpl({required this.movieDataSource});

  Future<Either<Failure, T>> _handleRequest<T>(
    Future<T> Function() request,
  ) async {
    try {
      final result = await request();
      return Right(result);
    } on HttpException catch (error) {
      debugPrint('Error HTTP remoto: $error');
      return Left(RemoteFailure());
    } on LocalFailure catch (error) {
      debugPrint('Error local DB: $error');
      return Left(LocalFailure());
    } catch (error) {
      debugPrint('Error inesperado: $error');
      return Left(RemoteFailure());
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getNowPlaying({int page = 1}) {
    return _handleRequest(() async {
      return movieDataSource.getNowPlaying();
    });
  }
}
