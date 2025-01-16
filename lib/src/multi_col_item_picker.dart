import 'package:flutter/material.dart';

import 'scroll_view.dart';

/// Dropdown scrollable picker to select multiple items
class DropdownMultiColItemPicker extends StatefulWidget {
  /// Creates a material design dropdown multi-column item picker
  const DropdownMultiColItemPicker(
      {super.key,
      required this.pickerTitle,
      required this.multiColItems,
      this.onChanged,
      this.scrollWheelHeight = 100,
      this.backgroundColor = Colors.white});

  /// Picker title
  final Widget pickerTitle;

  /// List of item widgets for the user to select from
  /// Input must be a 2d list (each row represent a list of item widgets for the user to select from)
  final List<List<Widget>> multiColItems;

  /// Called when the user scrolls
  final ValueChanged<List<Widget>>? onChanged;

  /// Pixel height of the scrollwheel
  final double scrollWheelHeight;

  /// Picker background color
  final Color backgroundColor;

  @override
  State<DropdownMultiColItemPicker> createState() =>
      _DropdownMultiItemPickerState();
}

class _DropdownMultiItemPickerState extends State<DropdownMultiColItemPicker> {
  bool isToggle = false;
  late int nCols;
  late List<Widget> selectedItems;
  late List<ScrollController> controllers;

  @override
  void initState() {
    super.initState();

    nCols = widget.multiColItems.length;
    selectedItems =
        List.generate(nCols, (index) => widget.multiColItems[index][0]);
    controllers = List.generate(
        nCols, (_) => FixedExtentScrollController(initialItem: 0));
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
              child: SizedBox(
                height: 30,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(flex: 3, child: widget.pickerTitle),
                      Expanded(
                        flex: 6,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: nCols,
                            itemBuilder: (context, index) => SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.6 /
                                      nCols,
                                  child: selectedItems[index],
                                )),
                      ),
                      Flexible(
                          flex: 1,
                          child: isToggle
                              ? Icon(Icons.arrow_drop_up)
                              : Icon(Icons.arrow_drop_down))
                    ]),
              ),
            ),
            Visibility(
              visible: isToggle,
              child: Column(
                children: [
                  Divider(),
                  SizedBox(
                    height: widget.scrollWheelHeight,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: nCols,
                        itemBuilder: (context, colIndex) => ItemScrollView(
                              key: PageStorageKey(hashCode + colIndex),
                              width: MediaQuery.of(context).size.width / nCols,
                              controller: controllers[colIndex],
                              items: widget.multiColItems[colIndex],
                              onChanged: (index) {
                                setState(() {
                                  selectedItems[colIndex] =
                                      widget.multiColItems[colIndex][index];
                                });
                                if (widget.onChanged != null) {
                                  widget.onChanged!(selectedItems);
                                }
                              },
                            )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
