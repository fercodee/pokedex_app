import 'dart:async';

import 'package:pokedex_app/domain/entities/pokemon_entity.dart';
import 'package:pokedex_app/domain/helpers/domain_error.dart';
import 'package:pokedex_app/domain/usecases/find_pokemon.dart';
import 'package:pokedex_app/ui/pages/home/home_page_presenter.dart';

class HomeState {
  late String pokemonName;
  late List<PokemonEntity> pokemons = [];
  bool isLoading = false;
}

class StreamHomePresenter implements HomePresenter {
  late final FindPokemon findPokemon;

  final _controller = StreamController<HomeState>.broadcast();
  final _state = HomeState();

  @override
  Stream<bool> get isLoadingStream =>
      _controller.stream.map((state) => state.isLoading).distinct();

  @override
  Stream<List<PokemonEntity>> get pokemons =>
      _controller.stream.map((state) => state.pokemons).distinct();

  StreamHomePresenter({required this.findPokemon});

  // TODO: Refactor method for get pokemon and pass for one stream
  @override
  void findPokemonByName(String name) async {
    _state.isLoading = true;
    _controller.add(_state);

    try {
      final query = await findPokemon.byName(name);
      _state.pokemons.add(query);
      _controller.add(_state);
    } on DomainError catch (error) {
      // TODO: Implement error state
      print(error);
    }
  }
}
