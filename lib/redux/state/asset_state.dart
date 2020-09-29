
import 'dart:math';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';

@immutable
class AssetState {
  final BuiltList<String> shipNames;

  AssetState({
    @required this.shipNames,
  });

  @override
  int get hashCode => shipNames.hashCode;

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is AssetState &&
    other.shipNames == shipNames;

  factory AssetState.createDefault() => AssetState(
    shipNames: BuiltList<String>(),
  );

  AssetState copyWith({
    BuiltList<String> shipNames,
  }) => AssetState(
    shipNames: shipNames ?? this.shipNames,
  );

  String getRandomShipName([String orElse]) {
    if (shipNames == null) return orElse;
    int index = Random().nextInt(shipNames.length);
    return shipNames[index];
  }
}