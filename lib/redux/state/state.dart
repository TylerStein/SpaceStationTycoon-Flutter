import 'package:flutter/foundation.dart';
import 'package:space_station_tycoon/redux/state/asset_state.dart';
import 'package:space_station_tycoon/redux/state/metadata_state.dart';
import 'package:space_station_tycoon/redux/state/module_state.dart';
import 'package:space_station_tycoon/redux/state/quest_state.dart';
import 'package:space_station_tycoon/redux/state/resource_state.dart';
import 'package:space_station_tycoon/redux/state/time_state.dart';
import 'package:space_station_tycoon/redux/state/unlock_state.dart';
import 'package:space_station_tycoon/redux/state/visitor_state.dart';

@immutable
class GameState {
  final AssetState assetState;
  final MetadataState metadataState;
  final BuiltModulesState moduleState;
  final QuestState questState;
  final ResourceState resourceState;
  final TimeState timeState;
  final UnlockState unlockState;
  final VisitorState visitorState;

  GameState({
    @required this.assetState,
    @required this.metadataState,
    @required this.moduleState,
    @required this.questState,
    @required this.resourceState,
    @required this.timeState,
    @required this.unlockState,
    @required this.visitorState,
  });

  GameState copyWith({
    AssetState assetState,
    MetadataState metadataState,
    BuiltModulesState moduleState,
    QuestState questState,
    ResourceState resourceState,
    TimeState timeState,
    UnlockState unlockState,
    VisitorState visitorState,
  }) => GameState(
    assetState: assetState ?? this.assetState,
    metadataState: metadataState ?? this.metadataState,
    moduleState: moduleState ?? this.moduleState,
    questState: questState ?? this.questState,
    resourceState: resourceState ?? this.resourceState,
    timeState: timeState ?? this.timeState,
    unlockState: unlockState ?? this.unlockState,
    visitorState: visitorState ?? this.visitorState,
  );

  factory GameState.createDefault() =>
    GameState(
      assetState: AssetState.createDefault(),
      metadataState: MetadataState.createDefault(),
      moduleState: BuiltModulesState.createDefault(),
      questState: QuestState.createDefault(),
      resourceState: ResourceState.createDefault(),
      timeState: TimeState.createDefault(),
      unlockState: UnlockState.createDefault(),
      visitorState: VisitorState.createDefault(),
    );
}