import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:space_station_tycoon/models/provider_models/asset_model.dart';
import 'package:space_station_tycoon/widgets/providers/notifier.dart';

class AssetProvider extends GameStateNotifier {
  AssetModel data;

  AssetProvider({
    @required this.data,
  });

  Future<void> loadData() async {
    await data.loadData();
    notifyOrMarkDirty(false);
  }

  String getRandomShipName(String fallback) {
    if (data?.shipNames?.isNotEmpty == true) {
      int index = Random().nextInt(data.shipNames.length);
      return data.shipNames[index];
    }

    return fallback;
  }

  factory AssetProvider.createDefault(BuildContext context) =>
    AssetProvider(data: AssetModel.createDefault());
}