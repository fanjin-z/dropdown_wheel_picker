import 'package:flutter/material.dart';

import 'scroll_view.dart';
import 'unit_type.dart';

class DropdownWeightPicker extends StatefulWidget {
  const DropdownWeightPicker(
      {super.key,
      required this.pickerTitle,
      this.onChanged,
      this.initialWieght,
      this.scrollWheelHeight = 100,
      this.backgroundColor = Colors.white});

  final Widget pickerTitle;
  final ValueChanged<Mass>? onChanged;
  final Mass? initialWieght;
  final double scrollWheelHeight;
  final Color backgroundColor;

  @override
  State<DropdownWeightPicker> createState() => _DropdownWeightPickerState();
}

class _DropdownWeightPickerState extends State<DropdownWeightPicker> {
  bool isToggle = false;
  Mass weight = Mass(0, 'kg');
  late ScrollController weightCtrl;

  @override
  void initState() {
    super.initState();
    if (widget.initialWieght != null) {
      weight.value = widget.initialWieght!.value;
      weight.unit = widget.initialWieght!.unit;
    }
    weightCtrl = FixedExtentScrollController(initialItem: weight.value.toInt());
  }

  @override
  void dispose() {
    weightCtrl.dispose();
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
            child: Column(children: [
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
                        Text('${weight.value} ${weight.unit}'),
                        isToggle
                            ? const Icon(Icons.arrow_drop_up)
                            : const Icon(Icons.arrow_drop_down)
                      ]),
                    ],
                  )),
              Visibility(
                  visible: isToggle,
                  child: Column(
                    children: [
                      Divider(),
                      Row(
                        children: [
                          const Text('Unit'),
                          Expanded(
                            child: ListTile(
                                contentPadding: const EdgeInsets.all(0),
                                horizontalTitleGap: 0,
                                title: const Text('kg'),
                                leading: Radio(
                                    value: 'kg',
                                    groupValue: weight.unit,
                                    onChanged: (String? unit) {
                                      if (unit != null) {
                                        setState(() {
                                          weight.unit = unit;
                                        });
                                        if (widget.onChanged != null) {
                                          widget.onChanged!(weight);
                                        }
                                      }
                                    })),
                          ),
                          Expanded(
                            child: ListTile(
                                contentPadding: const EdgeInsets.all(0),
                                horizontalTitleGap: 0,
                                title: const Text('lb'),
                                leading: Radio(
                                    value: 'lb',
                                    groupValue: weight.unit,
                                    onChanged: (String? unit) {
                                      if (unit != null) {
                                        setState(() {
                                          weight.unit = unit;
                                        });
                                        if (widget.onChanged != null) {
                                          widget.onChanged!(weight);
                                        }
                                      }
                                    })),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: widget.scrollWheelHeight,
                        child: ItemScrollView(
                          key: PageStorageKey(hashCode),
                          width: MediaQuery.of(context).size.width,
                          controller: weightCtrl,
                          items: List.generate(300, (index) => Text('$index')),
                          onChanged: (index) {
                            setState(() {
                              weight.value = index;
                            });
                            if (widget.onChanged != null) {
                              widget.onChanged!(weight);
                            }
                          },
                        ),
                      )
                    ],
                  ))
            ])));
  }
}
