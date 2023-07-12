import 'package:flutter/material.dart';
import 'package:pokedex_app/ui/components/components.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokédex',
      debugShowCheckedModeBanner: false,
      theme: makeAppTheme(),
      home: const HomePage(),
    );
  }
}
