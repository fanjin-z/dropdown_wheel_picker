import 'package:flutter/material.dart';

class ItemScrollView extends StatelessWidget {
  const ItemScrollView(
      {super.key,
      this.width,
      this.height,
      required this.items,
      required this.onChanged});

  final double? width;
  final double? height;
  final List<Widget> items;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ListWheelScrollView.useDelegate(
        onSelectedItemChanged: onChanged,
        itemExtent: 26,
        physics: const FixedExtentScrollPhysics(),
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
