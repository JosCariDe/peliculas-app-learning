
import 'package:dartz/dartz.dart';
import 'package:peliculas_app/core/errors/failure.dart';
import 'package:peliculas_app/features/credit/domain/entities/actor.dart';

abstract class CastRepository {
  Future<Either<Failure, List<Actor>>> getActorsByIdMovie(int id);
}