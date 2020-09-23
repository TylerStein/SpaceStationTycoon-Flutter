import 'package:flutter/foundation.dart';
import 'package:space_station_tycoon/models/modules/util/history_tracking_data.dart';

class ResourcesModel {
  HistoryTrackingData<int> credits;
  HistoryTrackingData<int> fuel;
  HistoryTrackingData<int> consumerGoods;
  HistoryTrackingData<int> repairParts;

  ResourcesModel({
    @required this.credits,
    @required this.fuel,
    @required this.consumerGoods,
    @required this.repairParts,
  });

  @override
  int get hashCode =>
    credits.hashCode ^
    fuel.hashCode ^
    consumerGoods.hashCode ^
    repairParts.hashCode;

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is ResourcesModel &&
    other.credits == credits &&
    other.fuel == fuel &&
    other.consumerGoods == consumerGoods &&
    other.repairParts == repairParts;

  factory ResourcesModel.createDefault() => ResourcesModel(
    credits: HistoryTrackingData<int>(0),
    fuel: HistoryTrackingData<int>(0),
    consumerGoods: HistoryTrackingData<int>(0),
    repairParts: HistoryTrackingData<int>(0),
  );
}