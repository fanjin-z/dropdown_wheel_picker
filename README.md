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

Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features

List what your package can do. Maybe include images, gifs, or videos.

## Getting started

List prerequisites and provide or point to information on how to
start using the package.

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

## Additional information

Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.
