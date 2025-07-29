import 'package:peliculas_app/features/credit/data/models/cast_only_response.dart';
import 'package:peliculas_app/features/credit/domain/entities/actor.dart';

class CastMapper {
  static Actor castOnlyDBToActor(Cast cast) {
    return Actor(
      id: cast.id,
      name: cast.name,
      profilePath: cast.profilePath!,
      character: cast.character,
    );
  }
}
