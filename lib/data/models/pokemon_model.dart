import 'package:pokedex_app/data/http/http.dart';
import 'package:pokedex_app/domain/entities/pokemon_entity.dart';

class PokemonModel {
  String name;
  Map<String, dynamic> sprites;
  int id;

  PokemonModel({required this.name, required this.sprites, required this.id});

  factory PokemonModel.fromJson(Map json) {
    if (!json.containsKey('name')) {
      throw HttpError.invalidData;
    }

    return PokemonModel(
        name: json['name'], sprites: json['sprites'], id: json['id']);
  }

  PokemonEntity toEntity() =>
      PokemonEntity(name: name, sprites: sprites, id: id);
}
