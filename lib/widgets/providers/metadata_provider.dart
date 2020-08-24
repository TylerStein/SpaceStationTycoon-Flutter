import 'package:flutter/widgets.dart';
import 'package:space_station_tycoon/models/provider_models/metadata_model.dart';
import 'package:space_station_tycoon/widgets/providers/notifier.dart';

class MetadataProvider extends GameStateNotifier {
  MetadataModel data;
  
  MetadataProvider({
    @required this.data,
  });

  void setName(String name, [bool notify = true]) {
    data.name = name;
    notifyOrMarkDirty(notify);
  }

  void setDay(int day, [bool notify = true]) {
    data.day = day;
    notifyOrMarkDirty(notify);
  }

  factory MetadataProvider.createDefault(BuildContext context) =>
    MetadataProvider(data: MetadataModel.createDefault());
}