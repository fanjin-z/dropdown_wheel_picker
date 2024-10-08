import 'package:dropdown_wheel_picker/src/scroll_view.dart';
import 'package:flutter/material.dart';

import 'unit_type.dart';

class DropdownDistancePicker extends StatefulWidget {
  const DropdownDistancePicker(
      {super.key,
      required this.pickerTitle,
      this.onChanged,
      this.initialDistance,
      this.scrollWheelHeight = 100,
      this.backgroundColor = Colors.white});

  final Widget pickerTitle;
  final ValueChanged<Length>? onChanged;
  final Length? initialDistance;
  final double scrollWheelHeight;
  final Color backgroundColor;

  @override
  State<DropdownDistancePicker> createState() => _DropdownDistancePickerState();
}

class _DropdownDistancePickerState extends State<DropdownDistancePicker> {
  bool isToggle = false;
  Length length = Length(0, 'km');
  late ScrollController wholeCtrl;
  late ScrollController fractionCtrl;

  @override
  void initState() {
    super.initState();

    int whole = 0;
    int fraction = 0;
    if (widget.initialDistance != null) {
      length = widget.initialDistance!;
      whole = length.value.truncate();
      if (length.unit == 'km' || length.unit == 'mi') {
        fraction = ((length.value - whole) * 10).truncate();
      }
    }

    wholeCtrl = FixedExtentScrollController(initialItem: whole);
    fractionCtrl = FixedExtentScrollController(initialItem: fraction);
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
                      Text('${length.value} ${length.unit}'),
                      isToggle
                          ? Icon(Icons.arrow_drop_up)
                          : Icon(Icons.arrow_drop_down)
                    ]),
                  ],
                )),
            
            Visibility(
              visible: isToggle,
              child: Column(
                children: [
                  Divider(),
                  Row(children: [
                    Text('Unit'),
                    Expanded(
                      child: ListTile(
                          contentPadding: EdgeInsets.all(0),
                          horizontalTitleGap: 0,
                          title: Text('km'),
                          leading: Radio(
                              value: 'km',
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
                          contentPadding: EdgeInsets.all(0),
                          horizontalTitleGap: 0,
                          title: Text('m'),
                          leading: Radio(
                              value: 'm',
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
                          contentPadding: EdgeInsets.all(0),
                          horizontalTitleGap: 0,
                          title: Text('mi'),
                          leading: Radio(
                              value: 'mi',
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
                  if (length.unit == 'km' || length.unit == 'mi')
                    SizedBox(
                      height: widget.scrollWheelHeight,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          ItemScrollView(
                              key: PageStorageKey(hashCode),
                              width: MediaQuery.of(context).size.width / 2,
                              controller: wholeCtrl,
                              items:
                                  List.generate(100, (index) => Text('$index')),
                              onChanged: (index) {
                                setState(() {
                                  final whole = length.value.truncate();
                                  final fraction = length.value - whole;
                                  length.value = index + fraction;
                                });
                                if (widget.onChanged != null) {
                                  widget.onChanged!(length);
                                }
                              }),
                          ItemScrollView(
                              key: PageStorageKey(hashCode + 1),
                              width: MediaQuery.of(context).size.width / 2,
                              controller: fractionCtrl,
                              items:
                                  List.generate(10, (index) => Text('.$index')),
                              onChanged: (index) {
                                setState(() {
                                  final whole = length.value.truncate();
                                  length.value = whole + index * 0.1;
                                });
                                if (widget.onChanged != null) {
                                  widget.onChanged!(length);
                                }
                              }),
                        ],
                      ),
                    ),
                  if (length.unit == 'm')
                    SizedBox(
                      height: widget.scrollWheelHeight,
                      child: ItemScrollView(
                        key: PageStorageKey(hashCode + 2),
                        width: MediaQuery.of(context).size.width,
                        controller: wholeCtrl,
                        items: List.generate(
                            21, (index) => Text('${index * 100}')),
                        onChanged: (index) {
                          setState(() {
                            length.value = index * 100;
                          });
                          if (widget.onChanged != null) {
                            widget.onChanged!(length);
                          }
                        },
                      ),
                    )
                ],
              ),
              )
          ],
        ),
      ),
    );
  }
}
