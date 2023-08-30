import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/presentation/presenters/presenters.dart';
import 'package:pokedex_app/ui/pages/home/components/components.dart';
import 'package:pokedex_app/ui/pages/home/components/pokemon_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final background = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leadingWidth: 48,
        title: const Text(
          'Pokedéx',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: const Icon(
          IconData(0xe147, fontFamily: 'MaterialIcons'),
          color: Colors.white,
        ),
        backgroundColor: background,
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 40),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
            ),
            child: Row(
              children: [
                const Flexible(
                  child: TextFieldSearch(),
                ),
                IconButton(
                    onPressed: () {},
                    color: Colors.white,
                    style: ButtonStyle(backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                      return Colors.white;
                    })),
                    icon: Icon(
                      const IconData(0xf0216, fontFamily: 'MaterialIcons'),
                      color: background,
                    ))
              ],
            ),
          ),
        ),
      ),
      backgroundColor: background,
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
            margin: const EdgeInsets.only(top: 18),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white),
            width: double.infinity,
            height: 620.0,
            child: BlocBuilder<CubitHomePresenter, HomeState>(
                builder: (context, state) {
              if (state is LoadingState) {
                return CircularProgressIndicator();
              }

              if (state is LoadedState) {
                return GridView.builder(
                  itemCount: state.pokemons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return PokemonCard(
                      pokemon: state.pokemons[index],
                    );
                  },
                );
              }
              return const Text('Não há pokemons...');
            })

            // return Text(snapshot.error.toString());

            //return const SizedBox(
            //  width: 64,
            // height: 64,
            //child: CircularProgressIndicator());

            ),
      ),
    );
  }
}
