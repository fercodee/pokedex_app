import 'package:pokedex_app/domain/entities/pokemon_entity.dart';

abstract class HomePresenter {
  Future<PokemonEntity> findPokemonByName(String name);
  Stream<bool> get isLoadingStream;
}
