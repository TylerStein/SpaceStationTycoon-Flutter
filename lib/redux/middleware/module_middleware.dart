import 'package:redux/redux.dart';
import 'package:space_station_tycoon/redux/actions/game_actions.dart';
import 'package:space_station_tycoon/redux/state/state.dart';
import 'package:space_station_tycoon/redux/state/states.dart';

class ModuleMiddleware {
  List<Middleware<GameState>> buildAll() => [
    TypedMiddleware<GameState, RunModuleLogicAction>(buildHandleModuleLogicAction()),
  ];

  buildHandleModuleLogicAction() {
    return (Store<GameState> store, RunModuleLogicAction action, NextDispatcher next) async {
      action.module.updateModule(store);
    };
  }
}