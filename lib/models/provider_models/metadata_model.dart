import 'package:flutter/foundation.dart';

class MetadataModel {
  String name;
  int day;
  List<String> logs;

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
    logs: List<String>(),
  );
}