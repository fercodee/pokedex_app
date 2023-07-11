import 'dart:async';

import 'package:pokedex_app/domain/entities/pokemon_entity.dart';
import 'package:pokedex_app/domain/usecases/find_pokemon.dart';
import 'package:pokedex_app/ui/pages/home/home_page_presenter.dart';

class HomeState {
  late String pokemonName;
  bool isLoading = false;
}

class StreamHomePresenter implements HomePresenter {
  late final FindPokemon findPokemon;

  final _controller = StreamController<HomeState>.broadcast();
  final _state = HomeState();

  @override
  Stream<bool> get isLoadingStream =>
      _controller.stream.map((state) => state.isLoading);

  StreamHomePresenter({required this.findPokemon});

  @override
  Future<PokemonEntity> findPokemonByName(String name) async {
    _state.isLoading = true;
    _controller.add(_state);
    return await findPokemon.byName(name);
  }
}
