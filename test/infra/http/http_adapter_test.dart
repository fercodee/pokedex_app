import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex_app/data/http/http.dart';
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
    Response response = Response('', 500);

    if (method == 'get') {
      response = await client.get(uri, headers: {
        'content-type': 'application/json',
        'accept': 'application/json'
      });
    }

    return _handleResponse(response);
  }

  Map _handleResponse(Response response) {
    if (response.statusCode == 200) {
      return response.body.isEmpty
          ? jsonDecode('{}')
          : jsonDecode(response.body);
    } else if (response.statusCode == 204) {
      return jsonDecode('{}');
    } else if (response.statusCode == 400) {
      throw HttpError.badRequest;
    } else if (response.statusCode == 401) {
      throw HttpError.unauthorized;
    } else {
      throw HttpError.serverError;
    }
  }
}

void main() {
  late HttpAdapter sut;
  late MockClient client;
  late String url;
  late String pokemonName;

  PostExpectation mockResquest() => when(
      client.get(Uri.https('example.com', url), headers: anyNamed('headers')));

  void mockResponse(int statusCode,
          {String body = '{"any_key": "any_value"}'}) =>
      mockResquest().thenAnswer((_) async => Response(body, statusCode));

  setUp(() {
    client = MockClient();
    sut = HttpAdapter(client);
    url = 'whatsit/create';
    pokemonName = faker.person.name();
  });

  group('get', () {
    setUp(() async {
      mockResponse(200);
    });

    test('Should call get with correct values', () async {
      await sut.request(url: url, method: 'get', pathParam: pokemonName);
      verify(client.get(Uri.https('example.com', url), headers: {
        'content-type': 'application/json',
        'accept': 'application/json'
      }));
    });

    test('Should return data if GET returns 200', () async {
      final response =
          await sut.request(url: url, method: 'get', pathParam: pokemonName);
      expect(response, {'any_key': 'any_value'});
    });

    test('Should return empty MAP if GET returns 200 with no data', () async {
      mockResponse(200, body: '');
      final response =
          await sut.request(url: url, method: 'get', pathParam: pokemonName);
      expect(response, {});
    });

    test('Should return empty MAP if GET returns 204', () async {
      mockResponse(204, body: '');
      final response =
          await sut.request(url: url, method: 'get', pathParam: pokemonName);
      expect(response, {});
    });

    test('Should return empty MAP if GET returns 204 with data', () async {
      mockResponse(204);
      final response =
          await sut.request(url: url, method: 'get', pathParam: pokemonName);
      expect(response, {});
    });

    test('Should return BadRequestError if Get returns 400', () async {
      mockResponse(400);
      final response = sut.request(url: url, method: 'get');
      expect(response, throwsA(HttpError.badRequest));
    });

    test('Should return BadRequestError if Get returns 401', () async {
      mockResponse(401);
      final response = sut.request(url: url, method: 'get');
      expect(response, throwsA(HttpError.unauthorized));
    });

    test('Should return ServerError if GET returns 500', () async {
      mockResponse(500);
      final future = sut.request(url: url, method: 'get');
      expect(future, throwsA(HttpError.serverError));
    });
  });
}
