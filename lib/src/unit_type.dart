/// Represents a measurement of length
class Length {
  /// numeric value of the length
  num value;

  /// Unit of length, must be on of ['m', 'km', 'mi']
  String unit;

  /// Creates a length object
  Length(this.value, this.unit);

  @override
  String toString() {
    return '${value.toString()} $unit';
  }
}

/// Represents a measurement of pace
class Pace {
  /// Duration of time to cover a given unit
  Duration duration;

  /// Unit of pace, must be on of ['/km', '/mi']
  String unit;

  /// Creates a pace object
  Pace(this.duration, this.unit);

  @override
  String toString() {
    return '${duration.toString()} $unit';
  }
}

/// Represents a measurement of mass
class Mass {
  /// numeric value of the mass
  num value;

  /// Unit of length, must be on of ['kg', 'lb']
  String unit;

  /// Creates a mass object
  Mass(this.value, this.unit);

  @override
  String toString() {
    return '${value.toString()} $unit';
  }
}
