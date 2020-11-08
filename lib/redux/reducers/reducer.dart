import 'package:space_station_tycoon/redux/actions/state_actions.dart';
import 'package:space_station_tycoon/redux/reducers/module_visitor_binding_state_reducer.dart';
import 'package:space_station_tycoon/redux/reducers/visitor_state_reducer.dart';
import 'package:space_station_tycoon/redux/state/state.dart';

GameState gameStateReducer(GameState state, dynamic action) {
  return GameState(
    visitorState: visitorReducer(state.visitorState, action),
    idState: state.idState,
    assetState: (action is SetAssetStateAction) ? action.state : state.assetState,
    metadataState: (action is SetMetadataStateAction) ? action.state : state.metadataState,
    moduleState: (action is SetBuiltModulesStateAction) ? action.state : state.moduleState,
    questState: (action is SetQuestStateAction) ? action.state : state.questState,
    resourceState: (action is SetResourceStateAction) ? action.state : state.resourceState,
    timeState: (action is SetTimeStateAction) ? action.state : state.timeState,
    unlockState: (action is SetUnlockStateActions) ? action.state : state.unlockState,
    moduleVisitorBindingState: moduleVisitorBindingStateReducer(state.moduleVisitorBindingState, action),
  );
}