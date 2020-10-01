import 'package:flutter/cupertino.dart';
import 'package:redux/redux.dart';
import 'package:space_station_tycoon/controllers/module_controller.dart';
import 'package:space_station_tycoon/controllers/visitor_controller.dart';
import 'package:space_station_tycoon/models/id.dart';
import 'package:space_station_tycoon/models/needs/visitor_needs.dart';
import 'package:space_station_tycoon/models/visitors/visitor.dart';
import 'package:space_station_tycoon/redux/actions/game_actions.dart';
import 'package:space_station_tycoon/redux/state/state.dart';
import 'package:space_station_tycoon/redux/state/states.dart';

class VisitorMiddleware {
  VisitorController visitorController;
  ModuleController moduleController;

  VisitorMiddleware({
    @required this.visitorController,
    @required this.moduleController,
  });

  List<Middleware<GameState>> buildAll() => [
    TypedMiddleware<GameState, GenerateVisitorAction>(buildHandleGenerateVisitorAction()),
    TypedMiddleware<GameState, RunVisitorLogicAction>(buildHandleVisitorLogicAction()),
  ];

  buildHandleGenerateVisitorAction() {
    return (Store<GameState> store, GenerateVisitorAction action, NextDispatcher next) async {
      ID id = store.state.idState.shipID;
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
      visitorController.updateVisitor(action.visitor, moduleController, store);
    };
  }
}