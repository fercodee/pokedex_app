import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/main/factories/pages/home/home_page.dart';
import 'package:pokedex_app/main/factories/usecases/find_pokemon_factory.dart';
import 'package:pokedex_app/presentation/presenters/cubit_home_presenters.dart';
import 'package:pokedex_app/ui/components/components.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokédex',
      debugShowCheckedModeBanner: false,
      theme: makeAppTheme(),
      home: BlocProvider(
        create: (context) => CubitHomePresenter(findPokemonUseCase: makeFindPokemon()),
        child: makeHomePage(),
      ) ,
    );
  }
}
