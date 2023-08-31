import 'package:pokedex_app/domain/entities/pokemon_entity.dart';

abstract class FindPokemon {
  Future<PokemonEntity> byName(String name);
  Future<List<PokemonEntity>> multiplePokemons(int limit);
}
