import 'package:flutter/material.dart';

class ItemScrollView extends StatelessWidget {
  const ItemScrollView({
    super.key,
    required this.items,
    required this.onChanged,
    this.width,
    this.height,
    this.controller,
  });

  final List<Widget> items;
  final ValueChanged<int> onChanged;
  final double? width;
  final double? height;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ListWheelScrollView.useDelegate(
        onSelectedItemChanged: onChanged,
        controller: controller,
        physics: const FixedExtentScrollPhysics(),
        itemExtent: 26,
        diameterRatio: 1.5,
        useMagnifier: true,
        magnification: 1.5,
        childDelegate: ListWheelChildBuilderDelegate(
            childCount: items.length,
            builder: (context, index) => items[index]),
      ),
    );
  }
}
