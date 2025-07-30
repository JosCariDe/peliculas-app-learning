import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_app/core/errors/failure.dart';
import 'package:peliculas_app/features/credit/data/data_sources/remote/cast_remote_data_source.dart';
import 'package:peliculas_app/features/credit/domain/entities/actor.dart';
import 'package:peliculas_app/features/credit/domain/repositories/cast_repository.dart';

class CastRespositoryImpl extends CastRepository {
  final CastRemoteDataSource castRemoteDataSource;

  CastRespositoryImpl({required this.castRemoteDataSource});

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
  Future<Either<Failure, List<Actor>>> getActorsByIdMovie(int id) {
    return _handleRequest(() async {
      return await castRemoteDataSource.getCastByIdMovie(id);
    });
  }
}
