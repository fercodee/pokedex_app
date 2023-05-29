import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex_app/domain/helpers/domain_error.dart';

import 'http/http_error.dart';
import 'search_test.mocks.dart';

abstract class HttpClient {
  Future<void> request(
      {@required String url, @required String method, String? pathParam});
}

class SearchUseCase {
  final HttpClient httpClient;
  final String url;

  SearchUseCase({required this.httpClient, required this.url});

  Future<void> findByName({required String name}) async {
    try {
      await httpClient.request(url: url, method: 'get', pathParam: name);
    } on HttpError {
      throw DomainError.unexpected;
    }
  }
}

@GenerateNiceMocks([MockSpec<HttpClient>()])
void main() {
  late String name;
  late String url;
  late MockHttpClient httpClient;
  late SearchUseCase sut;

  setUp(() {
    name = faker.person.name();
    url = faker.internet.httpUrl();
    httpClient = MockHttpClient();
    sut = SearchUseCase(httpClient: httpClient, url: url);
  });

  test('Should call HttpClient with correct values', () async {
    await sut.findByName(name: name);

    verify(httpClient.request(url: url, method: 'get', pathParam: name));
  });

  test('Should throw UnexpectedError if HttpClient returns 400', () async {
    when(httpClient.request(
            url: anyNamed('url'),
            method: anyNamed('method'),
            pathParam: anyNamed('pathParam')))
        .thenThrow(HttpError.badRequest);

    final future = sut.findByName(name: name);

    expect(future, throwsA(DomainError.unexpected));
  });
}
