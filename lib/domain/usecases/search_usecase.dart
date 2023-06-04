import 'package:pokedex_app/domain/entities/pokemon_entity.dart';

abstract class SearchUsecase {
  Future<PokemonEntity> findByName(String name);
}
