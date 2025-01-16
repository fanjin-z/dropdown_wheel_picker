import 'package:dropdown_wheel_picker/src/scroll_view.dart';
import 'package:flutter/material.dart';

/// Dropdown scrollable picker to select a date
class DropdownDatePicker extends StatefulWidget {
  /// Creates a material design dropdown date picker
  const DropdownDatePicker(
      {super.key,
      required this.pickerTitle,
      required this.initialDate,
      this.firstYear = 1980,
      this.lastYear = 2030,
      this.onChanged,
      this.scrollWheelHeight = 100,
      this.backgroundColor = Colors.white});

  /// Picker title
  final Widget pickerTitle;

  /// Initially selected date
  final DateTime initialDate;

  /// Earlist year that user can select
  final int firstYear;

  /// Latest year that user can select
  final int lastYear;

  /// Called when the user scrolls
  final ValueChanged<DateTime>? onChanged;

  /// Pixel height of the scrollwheel
  final double scrollWheelHeight;

  /// Picker background color
  final Color backgroundColor;

  @override
  State<DropdownDatePicker> createState() => _DropdownDatePickerState();
}

class _DropdownDatePickerState extends State<DropdownDatePicker> {
  bool isToggle = false;

  late int selectedYear;
  late int selectedMonth;
  late int selectedDay;
  late ScrollController yearCtrl;
  late ScrollController monthCtrl;
  late ScrollController dayCtrl;

  List<Widget> months = List.generate(12, (index) => Text(_monthAbbr[index]));

  @override
  void initState() {
    super.initState();

    selectedYear = widget.initialDate.year;
    selectedMonth = widget.initialDate.month;
    selectedDay = widget.initialDate.day;

    yearCtrl = FixedExtentScrollController(
        initialItem: selectedYear - widget.firstYear);
    monthCtrl = FixedExtentScrollController(initialItem: selectedMonth - 1);
    dayCtrl = FixedExtentScrollController(initialItem: selectedDay - 1);
  }

  @override
  void dispose() {
    yearCtrl.dispose();
    monthCtrl.dispose();
    dayCtrl.dispose();
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
                      Text(
                          '${_monthAbbr[selectedMonth - 1]} $selectedDay, $selectedYear'),
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
                  SizedBox(
                      height: widget.scrollWheelHeight,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          ItemScrollView(
                              key: PageStorageKey(hashCode),
                              controller: monthCtrl,
                              width: MediaQuery.of(context).size.width * 0.3,
                              items: months,
                              onChanged: (index) {
                                setState(() {
                                  selectedMonth = index + 1;
                                });
                                if (widget.onChanged != null) {
                                  widget.onChanged!(DateTime.utc(selectedYear,
                                      selectedMonth, selectedDay));
                                }
                              }),
                          ItemScrollView(
                              key: PageStorageKey(hashCode + 1),
                              controller: dayCtrl,
                              width: MediaQuery.of(context).size.width * 0.2,
                              items: List.generate(
                                  _daysInMonth(selectedYear, selectedMonth),
                                  (index) => Text('${index + 1}')),
                              onChanged: (index) {
                                setState(() {
                                  selectedDay = index + 1;
                                });
                                if (widget.onChanged != null) {
                                  widget.onChanged!(DateTime.utc(selectedYear,
                                      selectedMonth, selectedDay));
                                }
                              }),
                          ItemScrollView(
                              key: PageStorageKey(hashCode + 2),
                              controller: yearCtrl,
                              width: MediaQuery.of(context).size.width * 0.5,
                              items: List.generate(
                                  widget.lastYear - widget.firstYear + 1,
                                  (index) =>
                                      Text('${widget.firstYear + index}')),
                              onChanged: (index) {
                                setState(() {
                                  selectedYear = widget.firstYear + index;
                                });
                                if (widget.onChanged != null) {
                                  widget.onChanged!(DateTime.utc(selectedYear,
                                      selectedMonth, selectedDay));
                                }
                              }),
                        ],
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

const _monthDays = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

bool _isLeapYear(int year) =>
    (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));

int _daysInMonth(int year, int month) =>
    (month == 2 && _isLeapYear(year)) ? 29 : _monthDays[month];

const _monthAbbr = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dev'
];
