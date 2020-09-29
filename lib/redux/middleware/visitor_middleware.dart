import 'package:redux/redux.dart';
import 'package:space_station_tycoon/models/needs/visitor_needs.dart';
import 'package:space_station_tycoon/redux/actions/game_actions.dart';
import 'package:space_station_tycoon/redux/actions/state_actions.dart';
import 'package:space_station_tycoon/redux/state/state.dart';
import 'package:space_station_tycoon/redux/state/states.dart';

class VisitorMiddleware {
  List<Middleware<GameState>> buildAll() => [
    TypedMiddleware<GameState, GenerateVisitorAction>(buildHandleGenerateVisitorAction()),
    TypedMiddleware<GameState, RunVisitorLogicAction>(buildHandleVisitorLogicAction()),
    TypedMiddleware<GameState, RemoveVisitorAction>(buildHandleRemoveVisitorAction()),
  ];

  buildHandleGenerateVisitorAction() {
    return (Store<GameState> store, GenerateVisitorAction action, NextDispatcher next) async {
      VisitorID id = VisitorID.unique();
      String name = store.state.assetState.getRandomShipName(id.toString());

      Visitor visitor = Visitor(id: id, name: name);
      visitor.openNeeds.add(FuelingNeed(
        visitor: visitor,
        fuelTier: 1,
        fuelCount: 10,
      ));

      store.dispatch(AddVisitorAction(visitor));
    };
  }

  buildHandleVisitorLogicAction() {
    return (Store<GameState> store, RunVisitorLogicAction action, NextDispatcher next) async {
      action.visitor.updateVisitor(store);
    };
  }

  buildHandleRemoveVisitorAction() {
    return (Store<GameState> store, RemoveVisitorAction action, NextDispatcher next) async {
      //
    };
  }
}