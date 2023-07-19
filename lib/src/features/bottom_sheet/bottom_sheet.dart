import 'package:flutter/material.dart';

class BottomDrawer extends StatelessWidget {
  static const _sheetHeight = 80.0;
  static const _sheetRadius = Radius.circular(35.0);

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      isDismissible: false,
      enableDrag: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: _sheetRadius),
      ),
      context: context,
      builder: (_) => const BottomDrawer._(),
    );
  }

  const BottomDrawer._();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: _sheetHeight,
      child: Center(
        child: Text("Mizel be gie"),
      ),
    );
  }
}
