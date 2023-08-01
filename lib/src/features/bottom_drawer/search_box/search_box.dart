import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final void Function() onTap;
  final FocusNode focusNode;
  const SearchBox({
    required this.onTap,
    required this.focusNode,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(
        width: 5.0,
        color: Color(0xFF302F2F),
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: TextField(
        focusNode: focusNode,
        onTap: onTap,
        onTapOutside: (event) => focusNode.unfocus(),
        style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: const Color(0xFF444040),
          hintText: 'בוא להתנגד ב...',
          hintTextDirection: TextDirection.rtl,
          border: borderStyle,
          enabledBorder: borderStyle,
          focusedBorder: borderStyle,
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 20.0, right: 10.0),
            child: Icon(Icons.search, size: 32.0),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 30.0,
            vertical: 14.0,
          ),
        ),
      ),
    );
  }
}
