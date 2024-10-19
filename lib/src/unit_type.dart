class Length {
  num value;
  String unit; // ['m', 'km', 'mi'], ['cm', 'in']

  Length(this.value, this.unit);

  @override
  String toString() {
    return '${value.toString()} $unit';
  }
}

class Pace {
  Duration duration;
  String unit; // '/km', '/mi'

  Pace(this.duration, this.unit);

  @override
  String toString() {
    return '${duration.toString()} $unit';
  }
}

class Mass {
  num value;
  String unit; // 'kg', 'lb'

  Mass(this.value, this.unit);

  @override
  String toString() {
    return '${value.toString()} $unit';
  }
}
