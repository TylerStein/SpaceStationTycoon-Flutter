import 'package:flutter/widgets.dart';
import 'package:space_station_tycoon/models/provider_models/resources_model.dart';
import 'package:space_station_tycoon/widgets/providers/notifier.dart';

class ResourcesProvider extends GameStateNotifier {
  ResourcesModel data;

  ResourcesProvider({
    this.data,
  });

  int get fuel => data.fuel.value;
  int get fuelDifference => data.fuel.value - data.fuel.last;

  int get credits => data.credits.value;
  int get creditsDifference => data.credits.value - data.credits.last;

  void addFuel(int fuel, [bool notify = true]) {
    int value = data.fuel.value + fuel;
    if (value < 0) value = 0;
    data.fuel.value = value;

    notifyOrMarkDirty(notify);
  }

  void addCredits(int credits, [bool notify = true]) {
    data.credits.value += credits;
    notifyOrMarkDirty(notify);
  }

  factory ResourcesProvider.createDefault(BuildContext context) =>
    ResourcesProvider(data: ResourcesModel.createDefault());
}