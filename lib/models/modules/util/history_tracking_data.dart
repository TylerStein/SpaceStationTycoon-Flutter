class HistoryTrackingData<T> {
  Type get dataType => T;

  T _currentValue;
  T get value => _currentValue;

  T _lastValue;
  T get last => _lastValue;

  HistoryTrackingData(T initial) {
    _currentValue = initial;
    _lastValue = initial;
  }

  set value(T value) {
    _lastValue = _currentValue;
    _currentValue = value;
  }

  @override
  int get hashCode => _currentValue.hashCode ^ _lastValue.hashCode;

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is HistoryTrackingData &&
    this.dataType == other.dataType &&
    this._currentValue == other._currentValue &&
    this._lastValue == other._lastValue;
}
