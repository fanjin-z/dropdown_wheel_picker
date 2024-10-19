import 'package:flutter/material.dart';

import 'scroll_view.dart';
import 'unit_type.dart';

class DropdownHeightPicker extends StatefulWidget {
  const DropdownHeightPicker(
      {super.key,
      required this.pickerTitle,
      this.onChanged,
      this.initialHeight,
      this.scrollWheelHeight = 100,
      this.backgroundColor = Colors.white});

  final Widget pickerTitle;
  final ValueChanged<Length>? onChanged;
  final Length? initialHeight;
  final double scrollWheelHeight;
  final Color backgroundColor;

  @override
  State<DropdownHeightPicker> createState() => _DropdownHeightPickerState();
}

class _DropdownHeightPickerState extends State<DropdownHeightPicker> {
  bool isToggle = false;
  Length length = Length(0, 'cm');
  int whole = 0;
  int fraction = 0;
  late ScrollController wholeCtrl;
  late ScrollController fractionCtrl;

  @override
  void initState() {
    super.initState();

    if (widget.initialHeight != null) {
      length = widget.initialHeight!;
      if (length.unit == 'cm') {
        whole = length.value.truncate();
        wholeCtrl = FixedExtentScrollController(initialItem: whole - 140);
      } else if (length.unit == 'in') {
        whole = length.value ~/ 12;
        wholeCtrl = FixedExtentScrollController(initialItem: whole - 4);
        fraction = (length.value % 12).toInt();
      }
      fractionCtrl = FixedExtentScrollController(initialItem: fraction);
    }
  }

  @override
  void dispose() {
    wholeCtrl.dispose();
    fractionCtrl.dispose();
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
                isToggle = !isToggle;
              }),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  widget.pickerTitle,
                  Row(children: [
                    length.unit == 'in'
                        ? Text('${length.value ~/ 12}\' ${length.value % 12}"')
                        : Text('${length.value} ${length.unit}'),
                    isToggle
                        ? const Icon(Icons.arrow_drop_up)
                        : const Icon(Icons.arrow_drop_down)
                  ]),
                ],
              ),
            ),
            Visibility(
                visible: isToggle,
                child: Column(
                  children: [
                    Divider(),
                    Row(children: [
                      const Text('Unit'),
                      Expanded(
                        child: ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            horizontalTitleGap: 0,
                            title: const Text('Centimeters'),
                            leading: Radio(
                                value: 'cm',
                                groupValue: length.unit,
                                onChanged: (String? unit) {
                                  if (unit != null) {
                                    setState(() {
                                      length.unit = unit;
                                    });
                                    if (widget.onChanged != null) {
                                      widget.onChanged!(length);
                                    }
                                  }
                                })),
                      ),
                      Expanded(
                        child: ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            horizontalTitleGap: 0,
                            title: const Text('Imperial'),
                            leading: Radio(
                                value: 'in',
                                groupValue: length.unit,
                                onChanged: (String? unit) {
                                  if (unit != null) {
                                    setState(() {
                                      length.unit = unit;
                                    });
                                    if (widget.onChanged != null) {
                                      widget.onChanged!(length);
                                    }
                                  }
                                })),
                      ),
                    ]),
                    if (length.unit == 'cm')
                      SizedBox(
                        height: widget.scrollWheelHeight,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            ItemScrollView(
                                key: PageStorageKey(hashCode),
                                width: MediaQuery.of(context).size.width,
                                controller: wholeCtrl,
                                items: List.generate(
                                    90, (index) => Text('${index + 140}')),
                                onChanged: (index) {
                                  setState(() {
                                    length.value = index + 140;
                                  });
                                  if (widget.onChanged != null) {
                                    widget.onChanged!(length);
                                  }
                                }),
                          ],
                        ),
                      ),
                    if (length.unit == 'in')
                      SizedBox(
                        height: widget.scrollWheelHeight,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            ItemScrollView(
                                key: PageStorageKey(hashCode + 1),
                                width: MediaQuery.of(context).size.width / 2,
                                controller: wholeCtrl,
                                items: List.generate(
                                    5, (index) => Text('${index + 4}\'')),
                                onChanged: (index) {
                                  setState(() {
                                    whole = index + 4;
                                    length.value = whole * 12 + fraction;
                                  });
                                  if (widget.onChanged != null) {
                                    widget.onChanged!(length);
                                  }
                                }),
                            ItemScrollView(
                                key: PageStorageKey(hashCode + 2),
                                width: MediaQuery.of(context).size.width / 2,
                                controller: fractionCtrl,
                                items: List.generate(
                                    12, (index) => Text('$index"')),
                                onChanged: (index) {
                                  setState(() {
                                    fraction = index;
                                    length.value = whole * 12 + fraction;
                                  });
                                  if (widget.onChanged != null) {
                                    widget.onChanged!(length);
                                  }
                                }),
                          ],
                        ),
                      )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
