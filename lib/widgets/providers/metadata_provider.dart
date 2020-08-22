import 'package:flutter/widgets.dart';
import 'package:space_station_tycoon/models/provider_models/metadata_model.dart';

class MetadataProvider extends ChangeNotifier {
  MetadataModel data;
  
  MetadataProvider({
    @required this.data,
  });

  void setName(String name) {
    data.name = name;
    notifyListeners();
  }

  void setDay(int day) {
    data.day = day;
    notifyListeners();
  }

  factory MetadataProvider.createDefault(BuildContext context) =>
    MetadataProvider(data: MetadataModel.createDefault());
}