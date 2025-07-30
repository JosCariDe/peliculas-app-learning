import 'package:peliculas_app/features/credit/data/models/cast_response.dart';
import 'package:peliculas_app/features/credit/domain/entities/actor.dart';

abstract class CastRemoteDataSource {
  Future<List<Actor>> getCastByIdMovie(int id);
}
