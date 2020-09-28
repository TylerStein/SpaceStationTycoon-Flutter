import 'package:flutter/foundation.dart';

@immutable
class TimeState {
  final int frame;

  TimeState({
    @required this.frame,
  });

  @override
  int get hashCode => frame.hashCode;

  @override
  operator ==(Object other) =>
    identical(other, this) ||
    other is TimeState &&
    other.frame == frame;

  TimeState copyWith({
    Duration duration,
    int frame,
  }) => TimeState(
    frame: frame ?? this.frame,
  );

  factory TimeState.createDefault() =>
    TimeState(frame: 0);
}