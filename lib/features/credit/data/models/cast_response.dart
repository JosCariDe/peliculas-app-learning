
import 'package:peliculas_app/features/credit/data/models/cast_only_response.dart';

class CastResponse {
    final int id;
    final List<Cast> cast;
    final List<Cast> crew;

    CastResponse({
        required this.id,
        required this.cast,
        required this.crew,
    });

    factory CastResponse.fromJson(Map<String, dynamic> json) => CastResponse(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
        crew: List<Cast>.from(json["crew"].map((x) => Cast.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
        "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
    };
}


