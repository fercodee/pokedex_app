import 'package:flutter/material.dart';
import 'package:pokedex_app/main/factories/pages/home/home_page_factory.dart';
import 'package:pokedex_app/ui/components/components.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokédex',
      debugShowCheckedModeBanner: false,
      theme: makeAppTheme(),
      home: makeHomePage(),
    );
  }
}
