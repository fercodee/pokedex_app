import 'package:pokedex_app/main/factories/usecases/find_pokemon_factory.dart';
import 'package:pokedex_app/presentation/presenters/presenters.dart';
import 'package:pokedex_app/ui/pages/home/home_page_presenter.dart';

HomePresenter makeHomePresenter() {
  return StreamHomePresenter(findPokemon: makeFindPokemon());
}
