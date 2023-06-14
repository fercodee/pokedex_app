import 'package:flutter/material.dart';
import 'package:pokedex_app/ui/pages/home/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  final primaryColor = const Color.fromRGBO(197, 53, 50, 1);
  final contrastColor = const Color.fromRGBO(231, 231, 231, 1);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokédex',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
