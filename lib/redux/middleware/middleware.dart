import 'package:redux/redux.dart';
import 'package:space_station_tycoon/redux/middleware/asset_middleware.dart';
import 'package:space_station_tycoon/redux/state/state.dart';

List<Middleware<GameState>> buildGameStateMiddleware() => [
  ...AssetMiddleware().buildAll(),
];