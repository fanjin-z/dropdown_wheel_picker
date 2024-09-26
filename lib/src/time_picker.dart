import 'package:dropdown_wheel_picker/src/scroll_view.dart';
import 'package:flutter/material.dart';

class DropdownTimePicker extends StatefulWidget {
  const DropdownTimePicker(
      {super.key,
      required this.pickerTitle,
      this.onChanged,
      this.backgroundColor = Colors.white});

  final Widget pickerTitle;
  final ValueChanged<Duration>? onChanged;
  final Color backgroundColor;

  @override
  State<DropdownTimePicker> createState() => _DropdownTimePickerState();
}

class _DropdownTimePickerState extends State<DropdownTimePicker> {
  bool isToggle = false;
  int hours = 0;
  int minutes = 0;
  int seconds = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(20)),
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
                        Text(formatDuration(hours, minutes, seconds)),
                        isToggle
                            ? Icon(Icons.arrow_drop_up)
                            : Icon(Icons.arrow_drop_down)
                      ])
                    ],
                  )),
              if (isToggle)
                SizedBox(
                  height: 90,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      ItemScrollView(
                          width: MediaQuery.of(context).size.width / 3,
                          items: List.generate(24, (index) => Text('$index')),
                          onChanged: (index) {
                            setState(() {
                              hours = index;
                            });
                            if (widget.onChanged != null) {
                              widget.onChanged!(Duration(
                                  hours: hours,
                                  minutes: minutes,
                                  seconds: seconds));
                            }
                          }),
                      ItemScrollView(
                          width: MediaQuery.of(context).size.width / 3,
                          items: List.generate(60, (index) => Text('$index')),
                          onChanged: (index) {
                            setState(() {
                              minutes = index;
                            });
                            if (widget.onChanged != null) {
                              widget.onChanged!(Duration(
                                  hours: hours,
                                  minutes: minutes,
                                  seconds: seconds));
                            }
                          }),
                      ItemScrollView(
                          width: MediaQuery.of(context).size.width / 3,
                          items: List.generate(60, (index) => Text('$index')),
                          onChanged: (index) {
                            setState(() {
                              seconds = index;
                            });
                            if (widget.onChanged != null) {
                              widget.onChanged!(Duration(
                                  hours: hours,
                                  minutes: minutes,
                                  seconds: seconds));
                            }
                          }),
                    ],
                  ),
                )
            ],
          ),
        ));
  }
}

String formatDuration(int hours, int minutes, int seconds) {
  String durationStr =
      '${'$minutes'.padLeft(2, '0')}:${'$seconds'.padLeft(2, '0')}';
  if (hours > 0) {
    return '${'$hours'.padLeft(2, '0')}:$durationStr';
  }
  return durationStr;
}
