import 'package:dropdown_wheel_picker/dropdown_wheel_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 62, 58, 69)),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Column(
            children: [
              DropdownItemPicker(
                pickerTitle: Text('UN Security Council'),
                items: [
                  Text('China 🇨🇳'),
                  Text('France 🇫🇷'),
                  Text('Russia 🇷🇺'),
                  Text('United Kingdom 🇬🇧'),
                  Text('United States 🇺🇸'),
                ],
              ),
              DropdownMultiColItemPicker(
                  pickerTitle: Text('UN Nations'),
                  multiColItems: [
                    [
                      Text('China 🇨🇳'),
                      Text('France 🇫🇷'),
                      Text('Russia 🇷🇺'),
                      Text('United Kingdom 🇬🇧'),
                      Text('United States 🇺🇸'),
                    ],
                    [
                      Text('China 🇨🇳'),
                      Text('France 🇫🇷'),
                      Text('Russia 🇷🇺'),
                      Text('United Kingdom 🇬🇧'),
                      Text('United States 🇺🇸'),
                    ]
                  ]),
              DropdownDatePicker(
                pickerTitle: Text('Date Picker'),
                initialDate: DateTime(2024, 1, 1),
                firstYear: 2020,
                lastYear: 2025,
              )
            ],
          )),
    ));
  }
}
