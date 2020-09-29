import 'package:redux/redux.dart';
import 'package:space_station_tycoon/redux/middleware/asset_middleware.dart';
import 'package:space_station_tycoon/redux/middleware/game_middleware.dart';
import 'package:space_station_tycoon/redux/middleware/module_middleware.dart';
import 'package:space_station_tycoon/redux/middleware/visitor_middleware.dart';
import 'package:space_station_tycoon/redux/state/state.dart';

List<Middleware<GameState>> buildGameStateMiddleware() => [
  ...TimeMiddleware().buildAll(),
  ...AssetMiddleware().buildAll(),
  ...ModuleMiddleware().buildAll(),
  ...VisitorMiddleware().buildAll(),
];