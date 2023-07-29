import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 32.0),
        child: SearchBar(
          leading: Icon(
            Icons.search,
            size: 32.0,
          ),
        ),
      ),
    );
  }
}
