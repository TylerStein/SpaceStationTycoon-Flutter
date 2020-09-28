import 'package:flutter/foundation.dart';
import 'package:space_station_tycoon/models/modules/util/history_tracking_data.dart';

@immutable
class ResourceState {
  final HistoryTrackingData<int> credits;
  final HistoryTrackingData<int> fuel;
  final HistoryTrackingData<int> consumerGoods;
  final HistoryTrackingData<int> repairParts;

  ResourceState({
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
    other is ResourceState &&
    other.credits == credits &&
    other.fuel == fuel &&
    other.consumerGoods == consumerGoods &&
    other.repairParts == repairParts;

  factory ResourceState.createDefault() => ResourceState(
    credits: HistoryTrackingData<int>(0),
    fuel: HistoryTrackingData<int>(0),
    consumerGoods: HistoryTrackingData<int>(0),
    repairParts: HistoryTrackingData<int>(0),
  );

  
  ResourceState withAddFuel(int fuel) {
    int value = this.fuel.value + fuel;
    if (value < 0) value = 0;
    this.fuel.value = value;
    return this;
  }

  ResourceState withAddRepairParts(int parts) {
    int value = this.repairParts.value + parts;
    if (value < 0) value = 0;
    this.repairParts.value = value;
    return this;
  }

  ResourceState withAddCredits(int credits) {
    int value = this.credits.value + credits;
    if (value < 0) value = 0;
    this.credits.value = value;
    return this;
  }
}