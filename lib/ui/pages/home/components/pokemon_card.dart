import 'package:flutter/material.dart';
import 'package:pokedex_app/domain/entities/pokemon_entity.dart';

class PokemonCard extends StatelessWidget {
  final PokemonEntity pokemon;
  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Card(
        surfaceTintColor: Colors.white,
        clipBehavior: Clip.hardEdge,
        elevation: 3,
        child: SizedBox(
          width: 100,
          height: 120,
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              debugPrint('Card tapped');
            },
            child: Stack(
              children: [
                Positioned(
                  top: 60,
                  child: Container(
                    width: 120,
                    height: 50,
                    color: Theme.of(context).colorScheme.background,
                  ),
                ),
                Positioned(
                  left: 21,
                  top: 25,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 60,
                        child: Transform.scale(
                          scale: 3,
                          child: Image.network(
                            pokemon.sprites['front_default'],
                          ),
                        ),
                      ),
                      Text(pokemon.name),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
