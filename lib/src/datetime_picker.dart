import 'package:flutter/material.dart';

class DropdownDatePicker extends StatefulWidget {
  const DropdownDatePicker(
      {super.key,
      required this.pickerTitle,
      required this.items,
      this.onChanged});

  final Widget pickerTitle;
  final List<Widget> items;
  final ValueChanged<Widget>? onChanged;

  @override
  State<DropdownDatePicker> createState() => _DropdownDatePickerState();
}

class _DropdownDatePickerState extends State<DropdownDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
