class Length {
  double value;
  String unit;

  Length(this.value, this.unit);
}

class Pace {
  Duration duration;
  String unit;

  Pace(this.duration, this.unit);

  @override
  String toString() {
    return '${duration.toString()} $unit';
  }
}
