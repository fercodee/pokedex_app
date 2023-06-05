import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex_app/data/http/http.dart';
import 'package:pokedex_app/data/http/http_client.dart';
import 'package:pokedex_app/data/usecases/search.dart';
import 'package:pokedex_app/domain/helpers/helpers.dart';

import 'search_test.mocks.dart';

@GenerateNiceMocks([MockSpec<HttpClient>()])
void main() {
  late String name;
  late String url;
  late MockHttpClient httpClient;
  late SearchUseCase sut;
  late int id;

  Map mockValidData() => {
        "name": name,
        "sprites": {
          "back_default":
              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/25.png",
          "back_female":
              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/female/25.png",
        },
        "id": id
      };

  PostExpectation mockRequest() => when(httpClient.request(
      method: anyNamed('method'),
      url: anyNamed('url'),
      pathParam: anyNamed('pathParam')));

  void mockHttpData(Map data) {
    mockRequest().thenAnswer((_) async => data);
  }

  void mockHttpError(HttpError error) {
    mockRequest().thenThrow(error);
  }

  setUp(() {
    name = faker.person.name();
    id = faker.randomGenerator.integer(2);
    url = faker.internet.httpUrl();
    httpClient = MockHttpClient();
    sut = SearchUseCase(httpClient: httpClient, url: url);
    mockHttpData(mockValidData());
  });

  test('Should call HttpClient with correct values', () async {
    await sut.findByName(name);

    verify(httpClient.request(url: url, method: 'get', pathParam: name));
  });

  test('Should throw UnexpectedError if HttpClient returns 400', () async {
    mockHttpError(HttpError.badRequest);

    final future = sut.findByName(name);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw InvalidCredentials if HttpClient returns 401', () async {
    mockHttpError(HttpError.unauthorized);

    final future = sut.findByName(name);

    expect(future, throwsA(DomainError.invalidCredentials));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () async {
    mockHttpError(HttpError.notFound);

    final future = sut.findByName(name);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 500', () async {
    mockHttpError(HttpError.serverError);

    final future = sut.findByName(name);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should return an Pokemon if HttpClient returns 200', () async {
    final validData = mockValidData();
    final pokemon = await sut.findByName(name);

    expect(pokemon.name, validData['name']);
  });

  test(
      'Should throw UnexpectedError if HttpClient returns 200 with invalid data',
      () async {
    mockHttpData({"invalid_key": "invalid_value"});
    final future = sut.findByName(name);

    expect(future, throwsA(DomainError.unexpected));
  });
}
