import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:space_station_tycoon/models/id.dart';
import 'package:space_station_tycoon/models/visitors/visitor.dart';

@immutable
class VisitorState {
  final BuiltMap<ID, Visitor> visitors;

  VisitorState({
    @required this.visitors,
  });

  VisitorState copyWith({
    BuiltMap<ID, Visitor> visitors,
  }) => VisitorState(
    visitors: visitors ?? this.visitors,
  );

  factory VisitorState.createDefault() =>
    VisitorState(
      visitors: BuiltMap<ID, Visitor>(),
    );

  @override
  int get hashCode => visitors.hashCode;

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is VisitorState &&
    other.visitors == visitors;
}