import 'package:dropdown_wheel_picker/tile.dart';
import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  const Dropdown({super.key});

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  bool isToggle = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => setState(() {
              isToggle = !isToggle;
            }),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('BodyWeight'),
                  Row(children: [
                    Text('123'),
                    isToggle
                        ? Icon(Icons.arrow_drop_up)
                        : Icon(Icons.arrow_drop_down)
                  ]),
                ]),
          ),
          if (isToggle)
            Row(
              children: [
                SizedBox(
                  width: 100,
                  height: 300,
                  child: ListWheelScrollView.useDelegate(
                    onSelectedItemChanged: (value) => print(value),
                    itemExtent: 20,
                    physics: const FixedExtentScrollPhysics(),
                    childDelegate: ListWheelChildBuilderDelegate(
                        childCount: 50,
                        builder: (context, index) => Tile(index.toString())),
                  ),
                ),
                SizedBox(
                  width: 100,
                  height: 300,
                  child: ListWheelScrollView.useDelegate(
                    onSelectedItemChanged: (value) => print(value),
                    itemExtent: 20,
                    physics: const FixedExtentScrollPhysics(),
                    childDelegate: ListWheelChildBuilderDelegate(
                        childCount: 50,
                        builder: (context, index) => Tile(index.toString())),
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }
}

