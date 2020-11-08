import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import 'package:space_station_tycoon/controllers/module_controller.dart';
import 'package:space_station_tycoon/controllers/visitor_controller.dart';
import 'package:space_station_tycoon/redux/middleware/asset_middleware.dart';
import 'package:space_station_tycoon/redux/middleware/game_middleware.dart';
import 'package:space_station_tycoon/redux/middleware/module_middleware.dart';
import 'package:space_station_tycoon/redux/middleware/visitor_middleware.dart';
import 'package:space_station_tycoon/redux/state/state.dart';

List<Middleware<GameState>> buildGameStateMiddleware({
  @required VisitorController visitorController,
  @required ModuleController moduleController,
}) => [
  ...TimeMiddleware().buildAll(),
  ...AssetMiddleware().buildAll(),
  ...ModuleMiddleware().buildAll(),
  ...VisitorMiddleware(
    visitorController: visitorController,
    moduleController: moduleController,
  ).buildAll(),
];

buildLoggingMiddleware([String preLabel = 'LoggingMiddleware']) {
  return (Store<GameState> store, dynamic action, NextDispatcher next) async {
    print('$preLabel ${action.runtimeType.toString()}');
    next(action);
  };
}