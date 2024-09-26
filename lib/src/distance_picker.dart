import 'package:dropdown_wheel_picker/src/scroll_view.dart';
import 'package:flutter/material.dart';

class DropdownDistancePicker extends StatefulWidget {
  const DropdownDistancePicker(
      {super.key,
      required this.pickerTitle,
      this.onChanged,
      this.backgroundColor = Colors.white});

  final Widget pickerTitle;
  final ValueChanged<Length>? onChanged;
  final Color backgroundColor;

  @override
  State<DropdownDistancePicker> createState() => _DropdownDistancePickerState();
}

class _DropdownDistancePickerState extends State<DropdownDistancePicker> {
  bool isToggle = false;
  Length length = Length(0, 'km');

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
            if (isToggle)
              Column(
                children: [
                  Divider(),
                  Row(children: [
                    Text('Unit Selection'),
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
                      height: 90,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          ItemScrollView(
                              width: MediaQuery.of(context).size.width / 2,
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
                              width: MediaQuery.of(context).size.width / 2,
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
                      height: 90,
                      child: ItemScrollView(
                        width: MediaQuery.of(context).size.width,
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
              )
          ],
        ),
      ),
    );
  }
}

class Length {
  double value;
  String unit;

  Length(this.value, this.unit);
}
