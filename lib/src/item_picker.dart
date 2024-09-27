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
  final ValueChanged<Widget>? onChanged;
  final int initialItemIndex;
  final double scrollWheelHeight;
  final Color backgroundColor;

  @override
  State<DropdownItemPicker> createState() => _DropdownItemPickerState();
}

class _DropdownItemPickerState extends State<DropdownItemPicker> {
  bool isToggle = false;
  late int selectedIndex;
  late ScrollController controller;

  @override
  void initState() {
    super.initState();

    selectedIndex = widget.initialItemIndex;
    controller = FixedExtentScrollController(initialItem: selectedIndex);
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
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => setState(() {
                if (isToggle) {
                  controller =
                      FixedExtentScrollController(initialItem: selectedIndex);
                }
                isToggle = !isToggle;
              }),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    widget.pickerTitle,
                    Row(children: [
                      widget.items[selectedIndex],
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
                  ItemScrollView(
                    width: MediaQuery.of(context).size.width,
                    height: widget.scrollWheelHeight,
                    controller: controller,
                    items: widget.items,
                    onChanged: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                      if (widget.onChanged != null) {
                        widget.onChanged!(widget.items[index]);
                      }
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class DropdownMultiColItemPicker extends StatefulWidget {
  const DropdownMultiColItemPicker(
      {super.key,
      required this.pickerTitle,
      required this.multiColItems,
      this.onChanged,
      this.scrollWheelHeight = 100,
      this.backgroundColor = Colors.white});

  final Widget pickerTitle;
  final List<List<Widget>> multiColItems;
  final ValueChanged<List<Widget>>? onChanged;
  final double scrollWheelHeight;
  final Color backgroundColor;

  @override
  State<DropdownMultiColItemPicker> createState() =>
      _DropdownMultiItemPickerState();
}

class _DropdownMultiItemPickerState extends State<DropdownMultiColItemPicker> {
  bool isToggle = false;
  late int nCols;
  late List<int> selectedIndexes;
  late List<Widget> selectedItems;
  late List<ScrollController> controllers;

  @override
  void initState() {
    super.initState();

    nCols = widget.multiColItems.length;
    selectedIndexes = List.generate(nCols, (_) => 0);
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
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => setState(() {
                if (isToggle) {
                  for (var i = 0; i < nCols; i++) {
                    controllers[i] = FixedExtentScrollController(
                        initialItem: selectedIndexes[i]);
                  }
                }
                isToggle = !isToggle;
              }),
              child: SizedBox(
                height: 30,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
            if (isToggle)
              Column(
                children: [
                  Divider(),
                  SizedBox(
                    height: widget.scrollWheelHeight,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: nCols,
                        itemBuilder: (context, colIndex) => ItemScrollView(
                              width: MediaQuery.of(context).size.width / nCols,
                              controller: controllers[colIndex],
                              items: widget.multiColItems[colIndex],
                              onChanged: (index) {
                                setState(() {
                                  selectedIndexes[colIndex] = index;
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
          ],
        ),
      ),
    );
  }
}
