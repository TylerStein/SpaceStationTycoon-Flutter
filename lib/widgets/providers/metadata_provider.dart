import 'package:flutter/widgets.dart';
import 'package:space_station_tycoon/models/log_model.dart';
import 'package:space_station_tycoon/models/provider_models/metadata_model.dart';
import 'package:space_station_tycoon/widgets/providers/notifier.dart';

class MetadataProvider extends GameStateNotifier {
  final int maxLogLength = 100;
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

  void addLog(LogEvent log, [bool notify = true]) {
    if (data.logs.length > maxLogLength) {
      data.logs.removeLast();
    }

    data.logs.insert(0, log);
    notifyOrMarkDirty(notify);
  }

  factory MetadataProvider.createDefault(BuildContext context) =>
    MetadataProvider(data: MetadataModel.createDefault());
}