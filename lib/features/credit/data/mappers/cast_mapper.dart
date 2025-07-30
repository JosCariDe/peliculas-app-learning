import 'package:peliculas_app/features/credit/data/models/cast_only_response.dart';
import 'package:peliculas_app/features/credit/domain/entities/actor.dart';

class CastMapper {
  static Actor castOnlyDBToActor(Cast cast) {
    return Actor(
      id: cast.id,
      name: cast.name,
      profilePath: (cast.profilePath!!= '')
          ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
          : 'https://previews.123rf.com/images/macrovector/macrovector1806/macrovector180600296/102746545-glitch-style-poster-with-404-not-found-text-on-screen-with-destruction-pixels-structure-background.jpg',
      character: cast.character,
    );
  }
}
