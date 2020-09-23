import 'package:flutter/foundation.dart';
import 'package:space_station_tycoon/models/log_model.dart';

class MetadataModel {
  String name;
  int day;
  List<LogEvent> logs;

  MetadataModel({
    @required this.name,
    @required this.day,
    @required this.logs,
  });
  
  @override
  int get hashCode => name.hashCode ^ day.hashCode ^ logs.length.hashCode;

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is MetadataModel &&
    other.name == name &&
    other.day == day &&
    other.logs.length == logs.length;

  factory MetadataModel.createDefault() => MetadataModel(
    name: 'New Space Station',
    day: 0,
    logs: List<LogEvent>(),
  );
}