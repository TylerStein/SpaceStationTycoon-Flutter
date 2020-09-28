import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:space_station_tycoon/models/log_model.dart';

@immutable
class MetadataState {
  final int maxLogLength = 100;
  final String name;
  final int day;
  final BuiltList<LogEvent> logs;

  MetadataState({
    @required this.name,
    @required this.day,
    @required this.logs,
  });
  
  @override
  int get hashCode => name.hashCode ^ day.hashCode ^ logs.hashCode;

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is MetadataState &&
    other.name == name &&
    other.day == day &&
    other.logs == logs;

  factory MetadataState.createDefault() => MetadataState(
    name: 'New Space Station',
    day: 0,
    logs: BuiltList<LogEvent>(),
  );

  MetadataState copyWith({
    String name,
    int day,
    BuiltList<LogEvent> logs,
  }) => MetadataState(
    name: name ?? this.name,
    day: day ?? this.day,
    logs: logs ?? this.logs,
  );

  MetadataState withAddedLog(LogEvent log) {
    ListBuilder<LogEvent> updatedLogs = logs.toBuilder();
    if (logs.length > maxLogLength) {
      updatedLogs.removeLast();
    }

    updatedLogs.insert(0, log);
    return copyWith(logs: updatedLogs.build());
  }
}