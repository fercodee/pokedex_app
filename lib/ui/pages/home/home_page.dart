import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final background = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pokedéx',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: background,
        bottom: const PreferredSize(
          preferredSize: Size(double.infinity, 40),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.0,
            ),
            child: SizedBox(
              height: 50,
              child: TextField(
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    contentPadding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                    hintText: 'Search',
                    filled: true,
                    fillColor: Colors.white),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: background,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                margin: const EdgeInsets.only(top: 18),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white),
                width: double.infinity,
                height: 620.0,
              ),
            ),
          );
        },
      ),
    );
  }
}
