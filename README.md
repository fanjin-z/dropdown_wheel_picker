<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages). 
-->

Flutter package for dropdown scrollable wheel picker


![GitHub Repo stars](https://img.shields.io/github/stars/fanjin-z/dropdown_wheel_picker?style=flat-square)
![GitHub License](https://img.shields.io/github/license/fanjin-z/dropdown_wheel_picker?style=flat-square)
![Pub Version](https://img.shields.io/pub/v/dropdown_wheel_picker?style=flat-square)
![Pub Likes](https://img.shields.io/pub/likes/dropdown_wheel_picker?style=flat-square)
![Pub Popularity](https://img.shields.io/pub/popularity/dropdown_wheel_picker?style=flat-square)



## Features

| IOS | Android |
| --- | --- |
| <img src="https://github.com/fanjin-z/dropdown_wheel_picker/blob/c522d3caeb2ce499041e123eabf81385122414f5/assets/ios_screen_record.gif?raw=true" alt="IOS Screen Recordrawing" width="160"/> | <img src="https://github.com/fanjin-z/dropdown_wheel_picker/blob/c522d3caeb2ce499041e123eabf81385122414f5/assets/android_screen_record.gif?raw=true" alt="Android Screen Record" width="160"/> |

## Getting started

Prerequisites
- Dart >= 3.0
- Flutter

## Usage

Dropdown Item Picker
```dart
DropdownItemPicker(
    pickerTitle: Text('Countries'),
    items: [
        Text('China 🇨🇳'),
        Text('France 🇫🇷'),
        Text('Russia 🇷🇺'),
        Text('United Kingdom 🇬🇧'),
        Text('United States 🇺🇸'),
    ],
    onChanged: (value) => print('Selected Country: $value'),
)
```

Dropdown Multi-column Item Picker
```dart
DropdownMultiColItemPicker(
    pickerTitle: Text('Star Wars'),
    multiColItems: [
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
    ]
    onChanged: (value) => print('Selected Countries: $value'),
)
```

Dropdown Date Picker
```dart
DropdownDatePicker(
    pickerTitle: Text('Date Picker'),
    initialDate: DateTime(2024, 1, 1),
    firstYear: 2020,
    lastYear: 2025,
    onChanged: (value) => print('Selected Date: $value'),
)
```

Dropdown Distance Picker
```dart
DropdownDistancePicker(
    pickerTitle: Text('Distance Picker'),
    onChanged: (value) => print('${value.value} ${value.unit}'),
)
```

Dropdown Time Picker
```dart
DropdownTimePicker(
    pickerTitle: Text('Time Picker'),
    onChanged: (value) => print(value),
)
```

Dropdown Pace Picker
```dart
DropdownPacePicker(
    pickerTitle: Text('Pace Picker'),
    onChanged: (value) => print(value),
)
```

Dropdown Height Picker
```dart
DropdownHeightPicker(
    pickerTitle: Text('height'),
    initialHeight: Length(70, 'in'),
    onChanged: (value) => print(value)
)
              
```

Dropdown Weight Picker
```dart
DropdownWeightPicker(
    pickerTitle: Text('Weight'),
    initialWieght: Mass(150, 'lb'),
    onChanged: (value) => print(value)
)
```

## Additional information

Report bugs or issues in [Github Repo](https://github.com/fanjin-z/dropdown_wheel_picker). 
