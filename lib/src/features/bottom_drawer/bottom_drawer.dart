import 'package:flutter/material.dart';
import './events_list/events_list.dart';
import './search_box/search_box.dart';

class BottomDrawer extends StatefulWidget {
  static const drawerColor = Color.fromARGB(255, 41, 40, 40);
  static const notchGap = .05;
  static const topMargin = 12.0;
  static const sheetSizes = [.18, .4, 1.0];

  const BottomDrawer({super.key});

  @override
  State<BottomDrawer> createState() => _BottomDrawerState();
}

class _BottomDrawerState extends State<BottomDrawer> {
  final _draggableScrollController = DraggableScrollableController();
  final _searchBoxFocusNode = FocusNode();
  bool _topSnap = false;

  double _getHeight(BuildContext context) => MediaQuery.of(context).size.height;

  bool get _onTop =>
      _draggableScrollController.isAttached &&
      _draggableScrollController.size == BottomDrawer.sheetSizes[2];

  void _focusAndSnapSearchBoxToTop() {
    if (_onTop) return;
    _searchBoxFocusNode.unfocus();
    setState(() => _topSnap = true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _draggableScrollController.jumpTo(BottomDrawer.sheetSizes[2]);
      setState(() => _topSnap = false);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _searchBoxFocusNode.requestFocus();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DraggableScrollableSheet(
        controller: _draggableScrollController,
        initialChildSize: BottomDrawer.sheetSizes[1],
        minChildSize: BottomDrawer.sheetSizes[0],
        maxChildSize: BottomDrawer.sheetSizes[2],
        builder: (BuildContext context, ScrollController scrollController) {
          return NotificationListener(
            onNotification: (notification) {
              if (notification is DraggableScrollableNotification) {
                final pos = ((notification.extent * 10).floor() / 10);
                final listPos = scrollController.positions.last.pixels;
                if (pos < 1.0 && listPos > 0.0) {
                  scrollController.positions.last.jumpTo(0.0);
                }
              }
              return true;
            },
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              controller: _topSnap ? null : scrollController,
              physics: const ClampingScrollPhysics(),
              child: Container(
                margin: const EdgeInsets.only(top: BottomDrawer.topMargin),
                height: _getHeight(context) - BottomDrawer.topMargin,
                decoration: const BoxDecoration(
                  color: BottomDrawer.drawerColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  ),
                ),
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: Column(
                    children: [
                      const _Notch(),
                      SearchBox(
                        onTap: _focusAndSnapSearchBoxToTop,
                        focusNode: _searchBoxFocusNode,
                      ),
                      Expanded(
                        child: EventsList(scrollController: scrollController),
                      )
                    ],
                  ),
                ),
              ),
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
      padding: const EdgeInsets.all(12.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: 80.0,
          height: 6.0,
          decoration: BoxDecoration(
            color: const Color(0x39FFFFFF),
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );
  }
}
