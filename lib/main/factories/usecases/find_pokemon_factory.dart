import 'package:pokedex_app/data/usecases/usecases.dart';
import 'package:pokedex_app/domain/usecases/usecases.dart';
import 'package:pokedex_app/main/factories/http/http_client_factory.dart';

FindPokemon makeFindPokemon() {
  return FindPokemonByNameUseCase(
      httpClient: makeHttpAdapter(), url: 'https://pokeapi.co/api/v2/pokemon/');
}
