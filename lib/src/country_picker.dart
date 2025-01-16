import 'package:dropdown_wheel_picker/src/scroll_view.dart';
import 'package:dropdown_wheel_picker/src/unsd_m49_country_code.dart';
import 'package:flutter/material.dart';

class DropdownCountryPicker extends StatefulWidget {
  const DropdownCountryPicker(
      {super.key,
      required this.pickerTitle,
      this.onChanged,
      this.scrollWheelHeight = 100,
      this.backgroundColor = Colors.white});

  final Widget pickerTitle;
  final ValueChanged<String>? onChanged;
  final double scrollWheelHeight;
  final Color backgroundColor;

  @override
  State<DropdownCountryPicker> createState() => _DropdownCountryPickerState();
}

class _DropdownCountryPickerState extends State<DropdownCountryPicker> {
  bool isToggle = false;
  String? selectedCountry;
  ScrollController scrollCtrl = FixedExtentScrollController();
  var countryItems = countryCode
      .map((country) => country['Country or Area'])
      .map((name) => Text(name.toString()))
      .toList();

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
                  Flexible(flex: 3, child: widget.pickerTitle),
                  Flexible(flex: 6, child: Text(selectedCountry ?? '')), 
                  Flexible(
                      flex: 1,
                      child: isToggle
                          ? const Icon(Icons.arrow_drop_up)
                          : const Icon(Icons.arrow_drop_down))
                ],
              ),
            ),
            Visibility(
                visible: isToggle,
                child: Column(
                  children: [
                    Divider(),
                    SearchBar(
                      leading: const Icon(Icons.search),
                      backgroundColor:
                          WidgetStateProperty.all(widget.backgroundColor),
                      onChanged: (value) {
                        setState(() {
                          countryItems = countryCode
                              .map((country) => country['Country or Area'])
                              .where(((name) => name
                                  .toString()
                                  .toLowerCase()
                                  .contains(value.toLowerCase())))
                              .map((name) => Text(name.toString()))
                              .toList();
                          if (countryItems.isNotEmpty) {
                            selectedCountry = countryItems[0].data;
                            if (widget.onChanged != null &&
                                selectedCountry != null) {
                              widget.onChanged!(selectedCountry!);
                            }
                          }
                          scrollCtrl
                              .jumpTo(scrollCtrl.position.minScrollExtent);
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                        height: widget.scrollWheelHeight,
                        child: ItemScrollView(
                            key: PageStorageKey(hashCode),
                            controller: scrollCtrl,
                            items: countryItems,
                            width: MediaQuery.of(context).size.width,
                            onChanged: (index) {
                              setState(() {
                                selectedCountry = countryItems[index].data;
                                if (widget.onChanged != null &&
                                    selectedCountry != null) {
                                  widget.onChanged!(selectedCountry!);
                                }
                              });
                            }))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
