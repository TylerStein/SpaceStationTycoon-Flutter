import 'package:space_station_tycoon/redux/actions/asset_actions.dart';
import 'package:space_station_tycoon/redux/actions/metadata_actions.dart';
import 'package:space_station_tycoon/redux/actions/module_actions.dart';
import 'package:space_station_tycoon/redux/actions/quest_actions.dart';
import 'package:space_station_tycoon/redux/actions/resource_actions.dart';
import 'package:space_station_tycoon/redux/actions/time_actions.dart';
import 'package:space_station_tycoon/redux/actions/unlock_actions.dart';
import 'package:space_station_tycoon/redux/actions/visitor_actions.dart';
import 'package:space_station_tycoon/redux/state/state.dart';

GameState gameStateReducer(GameState state, dynamic action) {
  return GameState(
    assetState: (action is SetAssetStateAction) ? action.state : state.assetState,
    metadataState: (action is SetMetadataStateAction) ? action.state : state.metadataState,
    moduleState: (action is SetBuiltModulesStateAction) ? action.state : state.moduleState,
    questState: (action is SetQuestStateAction) ? action.state : state.questState,
    resourceState: (action is SetResourceStateAction) ? action.state : state.resourceState,
    timeState: (action is SetTimeStateAction) ? action.state : state.timeState,
    unlockState: (action is SetUnlockStateActions) ? action.state : state.unlockState,
    visitorState: (action is SetVisitorStateAction) ? action.state : state.visitorState,
  );
}