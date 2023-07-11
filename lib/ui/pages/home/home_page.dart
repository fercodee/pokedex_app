import 'package:flutter/material.dart';

import 'home_page_presenter.dart';

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
                  child: TextField(
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          const IconData(0xe567, fontFamily: 'MaterialIcons'),
                          color: Theme.of(context).primaryColorLight,
                        ),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        contentPadding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                        hintText: 'Search',
                        filled: true,
                        fillColor: Colors.white),
                  ),
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
      body: Builder(builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            margin: const EdgeInsets.only(top: 18),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white),
            width: double.infinity,
            height: 620.0,
            child: ListView(),
          ),
        );
      }),
    );
  }
}
