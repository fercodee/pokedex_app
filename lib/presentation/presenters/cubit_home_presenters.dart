import 'package:equatable/equatable.dart';
import 'package:pokedex_app/domain/entities/pokemon_entity.dart';
import 'package:pokedex_app/domain/usecases/usecases.dart';
import 'package:pokedex_app/ui/pages/home/home_cubit_presenter.dart';

abstract class HomeState extends Equatable {}

class InitialState extends HomeState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class LoadedState extends HomeState {
  final List<PokemonEntity> pokemons;

  LoadedState(this.pokemons);

  @override
  List<Object?> get props => [pokemons];
}

class ErrorState extends HomeState {
  @override
  List<Object> get props => [];
}

class CubitHomePresenter extends HomeBaseCubitPresenter<HomeState> {
  final FindPokemon findPokemonUseCase;
  CubitHomePresenter({required this.findPokemonUseCase}) : super(InitialState());

  @override
  Future<void> findPokemonByName(String name) async {
    emit(LoadingState());
    try {
      final response = await findPokemonUseCase.byName(name);
      emit(LoadedState([response]));
    } catch (e) {
      print(e.toString());
      emit(ErrorState());
    }
  }
  
  Future<void> getMultiplesPokemons() async {
    emit(LoadingState());
    try {
      final response = await findPokemonUseCase.multiplePokemons(10);
      emit(LoadedState(response));
    } catch (e) {
      print(e.toString());
      emit(ErrorState());
    }
  }
}
