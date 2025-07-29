 
 import 'package:dartz/dartz.dart';
import 'package:peliculas_app/core/errors/failure.dart';
import 'package:peliculas_app/features/credit/domain/entities/actor.dart';
import 'package:peliculas_app/features/credit/domain/repositories/cast_repository.dart';

class GetActorsCaseUse {

  final CastRepository castRepository;

  GetActorsCaseUse({required this.castRepository});

  Future<Either<Failure, List<Actor>>> call(int idMovie)async{
    return await castRepository.getActorsByIdMovie(idMovie);
  }
 }
 