import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex_app/data/http/http_client.dart';

@GenerateNiceMocks([MockSpec<Client>()])
import 'http_adapter_test.mocks.dart';

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  @override
  Future<Map> request(
      {required String url, required String method, String? pathParam}) async {
    final uri = Uri.https('example.com', url);
    Response response = Response('{}', 500);

    if (method == 'get') {
      response = await client.get(uri, headers: {
        'content-type': 'application/json',
        'accept': 'application/json'
      });
    }

    return jsonDecode(response.body);
  }
}

void main() {
  late HttpAdapter sut;
  late MockClient client;
  late String url;
  late String pokemonName;

  Map mockValidData() => {
        "name": pokemonName,
        "sprites": {
          "back_default":
              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/25.png",
          "back_female":
              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/female/25.png",
        },
        "id": 25
      };

  void mockResponse(PostExpectation request,
          {String body = "{any_key: any_value}"}) =>
      request.thenAnswer((_) async => Response(body, 200));

  PostExpectation mockResquest() => when(
      client.get(Uri.https('example.com', url), headers: anyNamed('headers')));

  setUp(() {
    client = MockClient();
    sut = HttpAdapter(client);
    url = 'whatsit/create';
    pokemonName = faker.person.name();
  });

  group('get', () {
    setUp(() async {
      final data = mockValidData();
      mockResponse(mockResquest(), body: jsonEncode(data));
    });

    test('Should call get with correct values', () async {
      await sut.request(url: url, method: 'get', pathParam: pokemonName);

      verify(client.get(Uri.https('example.com', url), headers: {
        'content-type': 'application/json',
        'accept': 'application/json'
      }));
    });

    test('Should return data if GET returns 200', () async {});
  });
}
