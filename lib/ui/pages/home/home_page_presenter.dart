import 'package:pokedex_app/domain/entities/pokemon_entity.dart';

abstract class HomePresenter {
  void findPokemonByName(String name);
  Stream<bool> get isLoadingStream;
  Stream<List<PokemonEntity>> get pokemons;
}
