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
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                DropdownItemPicker(
                  pickerTitle: const Text('Countries'),
                  items: const [
                    Text('China 🇨🇳'),
                    Text('France 🇫🇷'),
                    Text('Russia 🇷🇺'),
                    Text('United Kingdom 🇬🇧'),
                    Text('United States 🇺🇸'),
                  ],
                  onChanged: (value) => print('Selected Country: $value'),
                ),
                const SizedBox(height: 16),
                DropdownMultiColItemPicker(
                  pickerTitle: const Text('Star Wars'),
                  multiColItems: const [
                    [
                      Text('Jedi'),
                      Text('Empire'),
                    ],
                    [
                      Text('Luke'),
                      Text('Anakin'),
                      Text('Obi-Wan'),
                      Text('Han Solo'),
                      Text('Palpatine'),
                    ]
                  ],
                  onChanged: (value) => print('Selected Countries: $value'),
                ),
                const SizedBox(height: 16),
                DropdownDatePicker(
                  pickerTitle: const Text('Date Picker'),
                  initialDate: DateTime(2024, 1, 1),
                  firstYear: 2020,
                  lastYear: 2025,
                  onChanged: (value) => print('Selected Date: $value'),
                ),
                const SizedBox(height: 16),
                DropdownDistancePicker(
                  pickerTitle: const Text('Distance Picker'),
                  initialDistance: Length(2.5, 'mi'),
                  onChanged: (value) => print('${value.value} ${value.unit}'),
                ),
                const SizedBox(height: 16),
                DropdownTimePicker(
                  pickerTitle: const Text('Time Picker'),
                  initialTime:
                      const Duration(hours: 2, minutes: 0, seconds: 35),
                  onChanged: (value) => print(value),
                ),
                const SizedBox(height: 16),
                DropdownPacePicker(
                  pickerTitle: const Text('Pace Picker'),
                  initialPace:
                      Pace(const Duration(minutes: 6, seconds: 20), '/mi'),
                  onChanged: (value) => print(value),
                ),
                const SizedBox(height: 16),
                DropdownHeightPicker(
                    pickerTitle: const Text('height'),
                    initialHeight: Length(70, 'in'),
                    onChanged: (value) => print(value)),
                const SizedBox(height: 16),
                DropdownWeightPicker(
                    pickerTitle: const Text('Weight'),
                    initialWieght: Mass(150, 'lb'),
                    onChanged: (value) => print(value)),
                const SizedBox(height: 16),
                DropdownCountryPicker(
                  pickerTitle: const Text('Country'),
                  scrollWheelHeight: 120,
                  onChanged: (value) => print(value),
                ),
              ],
            ),
          )),
    ));
  }
}
