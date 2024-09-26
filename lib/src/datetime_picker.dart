import 'package:dropdown_wheel_picker/src/scroll_view.dart';
import 'package:flutter/material.dart';

class DropdownDatePicker extends StatefulWidget {
  const DropdownDatePicker(
      {super.key,
      required this.pickerTitle,
      required this.initialDate,
      required this.firstYear,
      required this.lastYear,
      this.onChanged,
      this.backgroundColor = Colors.white});

  final Widget pickerTitle;
  final DateTime initialDate;
  final int firstYear;
  final int lastYear;
  final ValueChanged<DateTime>? onChanged;
  final Color backgroundColor;

  @override
  State<DropdownDatePicker> createState() => _DropdownDatePickerState();
}

class _DropdownDatePickerState extends State<DropdownDatePicker> {
  bool isToggle = false;

  late int selectedYear;
  late int selectedMonth;
  late int selectedDay;

  List<Widget> months = List.generate(12, (index) => Text('${index + 1}'));

  @override
  void initState() {
    super.initState();

    selectedYear = widget.initialDate.year;
    selectedMonth = widget.initialDate.month;
    selectedDay = widget.initialDate.day;
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
                      Text('$selectedYear - $selectedMonth - $selectedDay'),
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
                      height: 90,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          ItemScrollView(
                              width: MediaQuery.of(context).size.width / 3,
                              items: List.generate(
                                  widget.lastYear - widget.firstYear + 1,
                                  (index) =>
                                      Text('${widget.firstYear + index}')),
                              onChanged: (index) {
                                setState(() {
                                  selectedYear = widget.firstYear + index;
                                });
                                if (widget.onChanged != null) {
                                  widget.onChanged!(DateTime(selectedYear,
                                      selectedMonth, selectedDay));
                                }
                              }),
                          ItemScrollView(
                              width: MediaQuery.of(context).size.width / 3,
                              items: months,
                              onChanged: (index) {
                                setState(() {
                                  selectedMonth = index + 1;
                                });
                                if (widget.onChanged != null) {
                                  widget.onChanged!(DateTime(selectedYear,
                                      selectedMonth, selectedDay));
                                }
                              }),
                          ItemScrollView(
                              width: MediaQuery.of(context).size.width / 3,
                              items: List.generate(
                                  daysInMonth(selectedYear, selectedMonth),
                                  (index) => Text('${index + 1}')),
                              onChanged: (index) {
                                setState(() {
                                  selectedDay = index + 1;
                                });
                                if (widget.onChanged != null) {
                                  widget.onChanged!(DateTime(selectedYear,
                                      selectedMonth, selectedDay));
                                }
                              }),
                        ],
                      ))
                ],
              )
          ],
        ),
      ),
    );
  }
}

const _daysInMonth = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

bool isLeapYear(int year) =>
    (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));

int daysInMonth(int year, int month) =>
    (month == 2 && isLeapYear(year)) ? 29 : _daysInMonth[month];
