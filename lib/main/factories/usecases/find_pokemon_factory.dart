import 'package:pokedex_app/data/usecases/usecases.dart';
import 'package:pokedex_app/domain/usecases/usecases.dart';
import 'package:pokedex_app/main/factories/http/http_client_factory.dart';

FindPokemon makeFindPokemon() {
  return FindPokemonUseCase(httpClient: makeHttpAdapter(), url: 'pokeapi.co');
}
