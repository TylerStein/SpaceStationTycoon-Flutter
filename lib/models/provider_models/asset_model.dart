import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class AssetModel {
  List<String> shipNames;

  AssetModel({
    @required this.shipNames,
  });

  @override
  int get hashCode => shipNames?.length.hashCode;

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is AssetModel &&
    other.shipNames?.length == shipNames?.length;

  factory AssetModel.createDefault() => AssetModel(
    shipNames: List<String>(),
  );

  Future<void> loadData() async {
    try {
      String loadedShipNames = await rootBundle.loadString('assets/lists/ship_names.txt');
      LineSplitter lineSplitter = LineSplitter();
      shipNames = lineSplitter.convert(loadedShipNames);
    } catch (error) {
      print(error);
    }
  }
}