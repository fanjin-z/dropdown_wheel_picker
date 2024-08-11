import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  final String value;

  const Tile(this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(value));
  }
}
