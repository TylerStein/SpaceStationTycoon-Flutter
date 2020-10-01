import 'package:redux/redux.dart';
import 'package:space_station_tycoon/redux/actions/game_actions.dart';
import 'package:space_station_tycoon/redux/state/states.dart';

Reducer<ModuleVisitorBindingState> moduleVisitorBindingStateReducer = combineReducers([
  TypedReducer<ModuleVisitorBindingState, AddVisitorModuleBindingAction>(_addVisitorModuleBindingActionReducer),
  TypedReducer<ModuleVisitorBindingState, RemoveVisitorModuleBindingAction>(_removeVisitorModuleBindingAction)
]);

ModuleVisitorBindingState _addVisitorModuleBindingActionReducer(ModuleVisitorBindingState state, AddVisitorModuleBindingAction action) {
  return state.withAdded(moduleID: action.moduleID, visitorID: action.visitorID);
}

ModuleVisitorBindingState _removeVisitorModuleBindingAction(ModuleVisitorBindingState state, RemoveVisitorModuleBindingAction action) {
  if (action.moduleID != null && action.visitorID != null) {
    return state.withRemoved(visitorID: action.visitorID, moduleID: action.moduleID);
  } else if (action.moduleID != null) {
    return state.withRemovedModule(action.moduleID);
  } else if (action.visitorID != null) {
    return state.withRemovedVisitor(action.moduleID);
  } else {
    return state;
  }
}


