import 'package:flutter/foundation.dart';
import 'package:space_station_tycoon/redux/state/asset_state.dart';
import 'package:space_station_tycoon/redux/state/id_state.dart';
import 'package:space_station_tycoon/redux/state/metadata_state.dart';
import 'package:space_station_tycoon/redux/state/module_state.dart';
import 'package:space_station_tycoon/redux/state/quest_state.dart';
import 'package:space_station_tycoon/redux/state/resource_state.dart';
import 'package:space_station_tycoon/redux/state/states.dart';
import 'package:space_station_tycoon/redux/state/time_state.dart';
import 'package:space_station_tycoon/redux/state/unlock_state.dart';
import 'package:space_station_tycoon/redux/state/visitor_state.dart';

@immutable
class GameState {
  final AssetState assetState;
  final IDState idState;
  final MetadataState metadataState;
  final BuiltModulesState moduleState;
  final QuestState questState;
  final ResourceState resourceState;
  final TimeState timeState;
  final UnlockState unlockState;
  final VisitorState visitorState;
  final ModuleVisitorBindingState moduleVisitorBindingState;

  GameState({
    @required this.assetState,
    @required this.idState,
    @required this.metadataState,
    @required this.moduleState,
    @required this.questState,
    @required this.resourceState,
    @required this.timeState,
    @required this.unlockState,
    @required this.visitorState,
    @required this.moduleVisitorBindingState,
  });

  GameState copyWith({
    AssetState assetState,
    IDState idState,
    MetadataState metadataState,
    BuiltModulesState moduleState,
    QuestState questState,
    ResourceState resourceState,
    TimeState timeState,
    UnlockState unlockState,
    VisitorState visitorState,
    ModuleVisitorBindingState moduleVisitorBindingState,
  }) => GameState(
    assetState: assetState ?? this.assetState,
    idState: idState ?? this.idState,
    metadataState: metadataState ?? this.metadataState,
    moduleState: moduleState ?? this.moduleState,
    questState: questState ?? this.questState,
    resourceState: resourceState ?? this.resourceState,
    timeState: timeState ?? this.timeState,
    unlockState: unlockState ?? this.unlockState,
    visitorState: visitorState ?? this.visitorState,
    moduleVisitorBindingState: moduleVisitorBindingState ?? this.moduleVisitorBindingState,
  );

  factory GameState.createDefault() =>
    GameState(
      assetState: AssetState.createDefault(),
      idState: IDState.createDefault(),
      metadataState: MetadataState.createDefault(),
      moduleState: BuiltModulesState.createDefault(),
      questState: QuestState.createDefault(),
      resourceState: ResourceState.createDefault(),
      timeState: TimeState.createDefault(),
      unlockState: UnlockState.createDefault(),
      visitorState: VisitorState.createDefault(),
      moduleVisitorBindingState: ModuleVisitorBindingState.createDefault(),
    );

  @override
  int get hashCode =>
    assetState.hashCode ^
    idState.hashCode ^
    metadataState.hashCode ^
    moduleState.hashCode ^
    questState.hashCode ^
    resourceState.hashCode ^
    timeState.hashCode ^
    unlockState.hashCode ^
    visitorState.hashCode ^
    moduleVisitorBindingState.hashCode;

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is GameState &&
    other.assetState == assetState &&
    other.idState == idState &&
    other.metadataState == metadataState &&
    other.moduleState == moduleState &&
    other.questState == questState &&
    other.resourceState == resourceState &&
    other.timeState == timeState &&
    other.unlockState == unlockState &&
    other.visitorState == visitorState &&
    moduleVisitorBindingState == moduleVisitorBindingState;

}