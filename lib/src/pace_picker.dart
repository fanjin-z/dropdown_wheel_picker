import 'package:dropdown_wheel_picker/src/scroll_view.dart';
import 'package:flutter/material.dart';

import 'unit_type.dart';

class DropdownPacePicker extends StatefulWidget {
  const DropdownPacePicker(
      {super.key,
      required this.pickerTitle,
      this.onChanged,
      this.initialPace,
      this.scrollWheelHeight = 100,
      this.backgroundColor = Colors.white});

  final Widget pickerTitle;
  final ValueChanged<Pace>? onChanged;
  final Pace? initialPace;
  final double scrollWheelHeight;
  final Color backgroundColor;

  @override
  State<DropdownPacePicker> createState() => _DropdownPacePickerState();
}

class _DropdownPacePickerState extends State<DropdownPacePicker> {
  bool isToggle = false;
  Pace pace = Pace(Duration(), '/km');
  int selectedMinute = 0;
  int selectedSecond = 0;
  late ScrollController minuteCtrl;
  late ScrollController secondCtrl;



  @override
  void initState() {
    super.initState();

    if (widget.initialPace != null) {
      pace = widget.initialPace!;
      selectedMinute = pace.duration.inMinutes;
      selectedSecond = pace.duration.inSeconds % 60;
    }
    minuteCtrl = FixedExtentScrollController(initialItem: selectedMinute);
    secondCtrl = FixedExtentScrollController(initialItem: selectedSecond);
  }

  @override
  void dispose() {
    minuteCtrl.dispose();
    secondCtrl.dispose();
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
                    Text('$selectedMinute\'$selectedSecond" ${pace.unit}'),
                    isToggle
                        ? Icon(Icons.arrow_drop_up)
                        : Icon(Icons.arrow_drop_down)
                  ]),
                ],
              ),
            ),
            Visibility(
                visible: isToggle,
                child: Column(children: [
                  Divider(),
                  Row(
                    children: [
                      Text('Unit'),
                      Expanded(
                        child: ListTile(
                            contentPadding: EdgeInsets.all(0),
                            horizontalTitleGap: 0,
                            title: Text('/km'),
                            leading: Radio(
                                value: '/km',
                                groupValue: pace.unit,
                                onChanged: (String? unit) {
                                  if (unit != null) {
                                    setState(() {
                                      pace.unit = unit;
                                    });
                                    if (widget.onChanged != null) {
                                      widget.onChanged!(pace);
                                    }
                                  }
                                })),
                      ),
                      Expanded(
                        child: ListTile(
                            contentPadding: EdgeInsets.all(0),
                            horizontalTitleGap: 0,
                            title: Text('/mi'),
                            leading: Radio(
                                value: '/mi',
                                groupValue: pace.unit,
                                onChanged: (String? unit) {
                                  if (unit != null) {
                                    setState(() {
                                      pace.unit = unit;
                                    });
                                    if (widget.onChanged != null) {
                                      widget.onChanged!(pace);
                                    }
                                  }
                                })),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: widget.scrollWheelHeight,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        ItemScrollView(
                            key: PageStorageKey(hashCode),
                            width: MediaQuery.of(context).size.width / 2,
                            controller: minuteCtrl,
                            items:
                                List.generate(25, (index) => Text('$index\'')),
                            onChanged: (index) {
                              setState(() {
                                selectedMinute = index;
                                pace.duration = Duration(
                                    minutes: selectedMinute,
                                    seconds: selectedSecond);
                              });
                              if (widget.onChanged != null) {
                                widget.onChanged!(pace);
                              }
                            }),
                        ItemScrollView(
                            key: PageStorageKey(hashCode + 1),
                            width: MediaQuery.of(context).size.width / 2,
                            controller: secondCtrl,
                            items:
                                List.generate(60, (index) => Text('$index"')),
                            onChanged: (index) {
                              setState(() {
                                selectedSecond = index;
                                pace.duration = Duration(
                                    minutes: selectedMinute,
                                    seconds: selectedSecond);
                              });
                              if (widget.onChanged != null) {
                                widget.onChanged!(pace);
                              }
                            }),
                      ],
                    ),
                  )
                ]))
          ],
        ),
      ),
    );
  }
}
