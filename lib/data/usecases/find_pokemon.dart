import 'package:pokedex_app/data/http/http.dart';
import 'package:pokedex_app/data/models/pokemon_model.dart';
import 'package:pokedex_app/domain/entities/pokemon_entity.dart';
import 'package:pokedex_app/domain/usecases/usecases.dart';

import '../../domain/helpers/helpers.dart';

class FindPokemonUseCase implements FindPokemon {
  final HttpClient httpClient;
  final String url;

  FindPokemonUseCase({required this.httpClient, required this.url});

  @override
  Future<PokemonEntity> byName(String name) async {
    try {
      final response =
          await httpClient.request(url: url, method: 'get', pathParam: name);
      return PokemonModel.fromJson(response).toEntity();
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized
          ? DomainError.invalidCredentials
          : DomainError.unexpected;
    }
  }

  @override
  Future<List<PokemonEntity>> multiplePokemons(int limit) async {
    try {
      // Review HttpClient to pass limit
      final response = await httpClient.request(url: url, method: 'get');

      final Map<String, String> listOfLinks = response['results'].map((key, value) {
        return MapEntry(key, value);
      });

      final List<PokemonEntity> pokemons = [];

      listOfLinks.forEach((key, value) async {
        final response = await byName(key);
        pokemons.add(response);
      });


      /*
      * {
          "name": "bulbasaur",
          "url": "https://pokeapi.co/api/v2/pokemon/1/"
        }
      * */

      return pokemons;
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized
          ? DomainError.invalidCredentials
          : DomainError.unexpected;
    }
  }
}
