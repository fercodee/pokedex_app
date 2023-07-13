import 'package:flutter/material.dart';
import 'package:pokedex_app/main/factories/pages/home/home_presenter.dactory.dart';
import 'package:pokedex_app/ui/pages/home/home_page.dart';

Widget makeHomePage() {
  return HomePage(
    presenter: makeHomePresenter(),
  );
}
