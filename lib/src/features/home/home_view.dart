import 'package:flutter/material.dart';
import '../map/map_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const MapView(),
          SizedBox.expand(
            child: DraggableScrollableSheet(
              snap: true,
              snapSizes: const [.1, .4, 1.0],
              initialChildSize: .4,
              minChildSize: .1,
              maxChildSize: 1.0,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                    ),
                  ),
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: 25,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(title: Text('Item $index'));
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
