import 'package:http/http.dart';

import 'package:pokedex_app/data/http/http.dart';
import 'package:pokedex_app/infra/http/http.dart';

HttpClient makeHttpAdapter() {
  final client = Client();
  return HttpAdapter(client);
}
