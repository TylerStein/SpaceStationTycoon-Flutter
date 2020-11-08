import 'package:built_collection/built_collection.dart';
import 'package:redux/redux.dart';
import 'package:space_station_tycoon/models/id.dart';
import 'package:space_station_tycoon/models/visitors/visitor.dart';
import 'package:space_station_tycoon/redux/actions/game_actions.dart';
import 'package:space_station_tycoon/redux/actions/state_actions.dart';
import 'package:space_station_tycoon/redux/state/states.dart';

Reducer<VisitorState> visitorReducer = combineReducers([
  TypedReducer<VisitorState, SetVisitorStateAction>(_setVisitorStateActionReducer),
  TypedReducer<VisitorState, AddVisitorAction>(_addVisitorActionReducer),
  TypedReducer<VisitorState, RemoveVisitorAction>(_removeVisitorActionReducer),
]);

VisitorState _setVisitorStateActionReducer(VisitorState state, SetVisitorStateAction action) {
  return action.state;
}

VisitorState _addVisitorActionReducer(VisitorState state, AddVisitorAction action) {
  MapBuilder<ID, Visitor> visitors = state.visitors.toBuilder();
  visitors[action.visitor.id] = action.visitor;

  return state.copyWith(
    visitors: visitors.build(),
  );
}

VisitorState _removeVisitorActionReducer(VisitorState state, RemoveVisitorAction action) {
  MapBuilder<ID, Visitor> visitors = state.visitors.toBuilder();
  visitors.remove(action.visitor.id);

  return state.copyWith(
    visitors: visitors.build(),
  );
}