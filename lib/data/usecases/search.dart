import 'package:pokedex_app/data/http/http.dart';
import 'package:pokedex_app/data/models/pokemon_model.dart';
import 'package:pokedex_app/domain/entities/pokemon_entity.dart';

import '../../domain/helpers/helpers.dart';
import '../http/http_client.dart';

class SearchUseCase {
  final HttpClient httpClient;
  final String url;

  SearchUseCase({required this.httpClient, required this.url});

  Future<PokemonEntity> findByName(String name) async {
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
}
