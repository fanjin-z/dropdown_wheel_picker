import 'package:flutter/material.dart';

import 'scroll_view.dart';

class DropdownItemPicker extends StatefulWidget {
  DropdownItemPicker(
      {super.key,
      required this.pickerTitle,
      required this.items,
      this.onChanged,
      this.initialItemIndex = 0,
      this.scrollWheelHeight = 100,
      this.backgroundColor = Colors.white});

  final Widget pickerTitle;
  final List<Widget> items;
  final ValueChanged<(Widget, int)>? onChanged;
  final int initialItemIndex;
  final double scrollWheelHeight;
  final Color backgroundColor;

  @override
  State<DropdownItemPicker> createState() => _DropdownItemPickerState();
}

class _DropdownItemPickerState extends State<DropdownItemPicker> {
  bool isToggle = false;
  late Widget selectedItem;
  late ScrollController controller;

  @override
  void initState() {
    super.initState();

    selectedItem = widget.items[widget.initialItemIndex];
    controller =
        FixedExtentScrollController(initialItem: widget.initialItemIndex);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => setState(() {
                isToggle = !isToggle;
              }),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.pickerTitle,
                    Row(children: [
                      selectedItem,
                      SizedBox(width: 4),
                      isToggle
                          ? Icon(Icons.arrow_drop_up)
                          : Icon(Icons.arrow_drop_down)
                    ]),
                  ]),
            ),
            Visibility(
              visible: isToggle,
              child: Column(
                children: [
                  Divider(),
                  ItemScrollView(
                    key: PageStorageKey(hashCode),
                    width: MediaQuery.of(context).size.width,
                    height: widget.scrollWheelHeight,
                    controller: controller,
                    items: widget.items,
                    onChanged: (index) {
                      setState(() {
                        selectedItem = widget.items[index];
                      });
                      if (widget.onChanged != null) {
                        widget.onChanged!((widget.items[index], index));
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
