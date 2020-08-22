import 'package:flutter/widgets.dart';
import 'package:space_station_tycoon/models/provider_models/resources_model.dart';

class ResourcesProvider extends ChangeNotifier {
  ResourcesModel data;

  ResourcesProvider({
    this.data,
  });

  int get fuel => data.fuel.value;
  int get fuelDifference => data.fuel.value - data.fuel.last;

  int get credits => data.credits.value;
  int get creditsDifference => data.credits.value - data.credits.last;

  void addFuel(int fuel) {
    data.fuel.value += fuel;
    notifyListeners();
  }

  void addCredits(int credits) {
    data.credits.value += credits;
    notifyListeners();
  }

  factory ResourcesProvider.createDefault(BuildContext context) =>
    ResourcesProvider(data: ResourcesModel.createDefault());
}