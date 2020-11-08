
import 'dart:math';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';

@immutable
class AssetState {
  final bool isLoaded;
  final BuiltList<String> shipNames;

  AssetState({
    @required this.isLoaded,
    @required this.shipNames,
  });

  @override
  int get hashCode => shipNames.hashCode ^ isLoaded.hashCode;

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is AssetState &&
    other.isLoaded == isLoaded &&
    other.shipNames == shipNames;

  factory AssetState.createDefault() => AssetState(
    isLoaded: false,
    shipNames: BuiltList<String>(),
  );

  AssetState copyWith({
    bool isLoaded,
    BuiltList<String> shipNames,
  }) => AssetState(
    isLoaded: isLoaded != null ? isLoaded : this.isLoaded,
    shipNames: shipNames ?? this.shipNames,
  );

  String getRandomShipName([String orElse]) {
    if (shipNames == null || shipNames.isEmpty) return orElse;
    int index = Random().nextInt(shipNames.length);
    return shipNames[index];
  }
}