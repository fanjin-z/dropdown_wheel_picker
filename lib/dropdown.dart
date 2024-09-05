import 'package:dropdown_wheel_picker/tile.dart';
import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  const Dropdown({super.key});

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  bool isToggle = false;

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


class DropdownItemPicker extends StatefulWidget {
  DropdownItemPicker(
      {super.key,
      required this.pickerTitle,
      required this.items,
      this.onChanged})
      : backgroundColor = Colors.white;

  final Widget pickerTitle;
  final List<Widget> items;
  final ValueChanged<Widget>? onChanged;
  final Color? backgroundColor;

  @override
  State<DropdownItemPicker> createState() => _DropdownItemPickerState();
}

class _DropdownItemPickerState extends State<DropdownItemPicker> {
  bool isToggle = false;
  Widget? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
                    widget.pickerTitle,
                    Row(children: [
                      selectedItem ?? Text('    '),
                      isToggle
                          ? Icon(Icons.arrow_drop_up)
                          : Icon(Icons.arrow_drop_down)
                    ]),
                  ]),
            ),
            if (isToggle)
              Column(
                children: [
                  Divider(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 90,
                    child: ListWheelScrollView.useDelegate(
                      onSelectedItemChanged: (index) => setState(() {
                        selectedItem = widget.items[index];
                      }),
                      itemExtent: 20,
                      physics: const FixedExtentScrollPhysics(),
                      childDelegate: ListWheelChildBuilderDelegate(
                          childCount: widget.items.length,
                          builder: (context, index) => widget.items[index]),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
