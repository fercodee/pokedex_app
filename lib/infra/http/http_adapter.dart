import 'dart:convert';

import 'package:http/http.dart';

import '../../data/http/http.dart';

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  // TODO: Refactor url and params capture
  @override
  Future<Map> request(
      {required String url, required String method, String? pathParam}) async {
    final uri = Uri.https(url, '/api/v2/pokemon/$pathParam');
    Response response = Response('', 500);

    try {
      if (method == 'get') {
        response = await client.get(uri, headers: {
          'content-type': 'application/json',
          'accept': 'application/json'
        });
      }
    } catch (e) {
      throw HttpError.serverError;
    }
    final result = _handleResponse(response);
    return result;
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
    } else if (response.statusCode == 403) {
      throw HttpError.forbidden;
    } else if (response.statusCode == 404) {
      throw HttpError.notFound;
    } else {
      throw HttpError.serverError;
    }
  }
}
