import 'package:flutter/material.dart';

class EventTile extends StatelessWidget {
  static const tileSize = 90.0;
  static const tileColor = Color(0xFF1C1C1C);
  static const tileShadowColor = Color.fromARGB(39, 125, 117, 117);
  static const tileTitleColor = Color.fromARGB(255, 107, 57, 137);
  static const textInfoColor = Color(0x83FFFFFF);

  const EventTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      child: SizedBox(
        width: double.infinity,
        height: tileSize,
        child: Container(
          decoration: BoxDecoration(
            color: tileColor,
            borderRadius: BorderRadius.circular(14.0),
            boxShadow: const [
              BoxShadow(
                color: tileShadowColor,
                blurRadius: 4,
                offset: Offset(0, 8.0),
              ),
            ],
          ),
          child: const Padding(
            padding: EdgeInsets.all(6.0),
            child: Row(
              children: [
                _EventDistance(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [_EventText(), _EventIcon()],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EventDistance extends StatelessWidget {
  const _EventDistance();

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0),
          child: Text(
            '2 km',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
              color: EventTile.textInfoColor,
            ),
          ),
        ),
      ),
    );
  }
}

class _EventIcon extends StatelessWidget {
  const _EventIcon();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(2.0),
      child: Icon(
        Icons.directions_walk_outlined,
        size: 42.0,
        color: EventTile.tileTitleColor,
      ),
    );
  }
}

class _EventText extends StatelessWidget {
  const _EventText();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          "צעדת ענק",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
            color: EventTile.tileTitleColor,
          ),
        ),
        Text(
          "מחלף איילון",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: EventTile.textInfoColor,
          ),
        ),
      ],
    );
  }
}
