import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_app/domain/entities/pokemon_entity.dart';

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

class CubitHomePresenter extends Cubit<HomeState> {
  CubitHomePresenter(super.initialState);
}
