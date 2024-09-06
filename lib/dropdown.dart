import 'package:flutter/material.dart';

class DropdownItemPicker extends StatefulWidget {
  DropdownItemPicker(
      {super.key,
      required this.pickerTitle,
      required this.items,
      this.onChanged,
      this.backgroundColor = Colors.white});

  final Widget pickerTitle;
  final List<Widget> items;
  final ValueChanged<Widget>? onChanged;
  final Color backgroundColor;

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


class DropdownMultiColItemPicker extends StatefulWidget {
  const DropdownMultiColItemPicker(
      {super.key,
      required this.pickerTitle,
      required this.multiColItems,
      this.onChanged,
      this.backgroundColor = Colors.white});

  final Widget pickerTitle;
  final List<List<Widget>> multiColItems;
  final ValueChanged<Widget>? onChanged;
  final Color backgroundColor;

  @override
  State<DropdownMultiColItemPicker> createState() =>
      _DropdownMultiItemPickerState();
}

class _DropdownMultiItemPickerState extends State<DropdownMultiColItemPicker> {
  bool isToggle = false;
  late int nCols;
  late List<Widget?> selectedItems;

  @override
  void initState() {
    super.initState();

    nCols = widget.multiColItems.length;
    selectedItems = List.generate(nCols, (_) => null);
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
                                  child: selectedItems[index] ?? Text('    '),
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
                    height: 90,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: nCols,
                        itemBuilder: (context, colIndex) {
                          final items = widget.multiColItems[colIndex];
                          return SizedBox(
                            width: MediaQuery.of(context).size.width / nCols,
                            child: ListWheelScrollView.useDelegate(
                              onSelectedItemChanged: (index) => setState(() {
                                selectedItems[colIndex] =
                                    widget.multiColItems[colIndex][index];
                              }),
                              itemExtent: 20,
                              physics: const FixedExtentScrollPhysics(),
                              childDelegate: ListWheelChildBuilderDelegate(
                                  childCount: items.length,
                                  builder: (context, index) => items[index]),
                            ),
                          );
                        }),
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}
