import 'package:flutter/material.dart';

class TextFieldSearch extends StatelessWidget {
  const TextFieldSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.start,
      decoration: InputDecoration(
          prefixIcon: Icon(
            const IconData(0xe567, fontFamily: 'MaterialIcons'),
            color: Theme.of(context).primaryColorLight,
          ),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          contentPadding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
          hintText: 'Search',
          filled: true,
          fillColor: Colors.white),
    );
  }
}
