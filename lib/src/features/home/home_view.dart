import 'package:flutter/material.dart';
import '../map/map_view.dart';
import '../bottom_drawer/bottom_drawer.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          MapView(),
          BottomDrawer(),
        ],
      ),
    );
  }
}
