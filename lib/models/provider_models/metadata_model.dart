import 'package:flutter/foundation.dart';

class MetadataModel {
  String name;
  int day;

  MetadataModel({
    @required this.name,
    @required this.day,
  });
  
  @override
  int get hashCode => name.hashCode ^ day.hashCode;

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is MetadataModel &&
    other.name == name &&
    other.day == day;

  factory MetadataModel.createDefault() => MetadataModel(name: 'New Space Station', day: 0);
}