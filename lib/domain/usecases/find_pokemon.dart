import 'package:pokedex_app/domain/entities/pokemon_entity.dart';

abstract class FindPokemonByName {
  Future<PokemonEntity> findByName(String name);
}
