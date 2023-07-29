import 'package:flutter/material.dart';
import './events_list/events_list.dart';
import './search_box/search_box.dart';

class BottomDrawer extends StatelessWidget {
  static const drawerColor = Color.fromARGB(255, 41, 40, 40);
  const BottomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DraggableScrollableSheet(
        snap: true,
        snapSizes: const [.1, .4, 1.0],
        initialChildSize: .4,
        minChildSize: .1,
        maxChildSize: 1.0,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: drawerColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
            ),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const _Notch(),
                const SizedBox(height: 20.0),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 180.0,
                  child: EventsList(scrollController: scrollController),
                ),
                const SearchBox(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Notch extends StatelessWidget {
  const _Notch();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: 86.0,
          height: 8.0,
          decoration: BoxDecoration(
            color: const Color.fromARGB(37, 255, 255, 255),
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );
  }
}
