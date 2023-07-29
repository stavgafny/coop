import 'package:flutter/material.dart';
import './event_tile.dart';

class EventsList extends StatelessWidget {
  final ScrollController scrollController;

  const EventsList({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: 20,
      itemBuilder: (BuildContext context, int index) {
        return const EventTile();
      },
    );
  }
}
