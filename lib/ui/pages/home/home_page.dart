import 'package:flutter/material.dart';
import 'package:pokedex_app/domain/entities/pokemon_entity.dart';
import 'package:pokedex_app/ui/pages/home/components/components.dart';
import 'package:pokedex_app/ui/pages/home/components/pokemon_card.dart';
import 'package:provider/provider.dart';
import './home_page_presenter.dart';

class HomePage extends StatefulWidget {
  final HomePresenter presenter;

  const HomePage({super.key, required this.presenter});

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
                Flexible(
                  child: Provider(
                      create: (_) => widget.presenter,
                      child: const TextFieldSearch()),
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
          child: StreamBuilder<List<PokemonEntity>>(
              stream: widget.presenter.pokemons,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                      width: 64,
                      height: 64,
                      child: CircularProgressIndicator());
                }
                if (snapshot.hasData) {
                  return GridView.builder(
                    itemCount: snapshot.data!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return PokemonCard(
                        pokemon: snapshot.data![index],
                      );
                    },
                  );
                }
                return const Text('Não há pokemons...');
              }),
        ),
      ),
    );
  }
}
