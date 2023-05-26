import 'dart:io';

import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_test.mocks.dart';

abstract class HttpClient {
  Future<void> request({@required String url, @required String method});
}

class SearchUseCase {
  final HttpClient httpClient;

  SearchUseCase({required this.httpClient});

  Future<void> findByName({required String name, required String url}) async {
    httpClient.request(url: url, method: 'get');
  }
}

@GenerateNiceMocks([MockSpec<HttpClient>()])
void main() {
  test('Should call HttpClient with correct values', () async {
    final httpClient = MockHttpClient();
    final sut = SearchUseCase(httpClient: httpClient);
    final name = faker.person.name();
    final url = faker.internet.httpUrl();

    await sut.findByName(name: name, url: url);

    verify(httpClient.request(url: url, method: 'get'));
  });
}
