import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:space_station_tycoon/controllers/module_controller.dart';
import 'package:space_station_tycoon/controllers/visitor_controller.dart';
import 'package:space_station_tycoon/frame_controller.dart';
import 'package:space_station_tycoon/presets/scenarios.dart';
import 'package:space_station_tycoon/redux/actions/engine_actions.dart';
import 'package:space_station_tycoon/redux/middleware/middleware.dart';
import 'package:space_station_tycoon/redux/reducers/reducer.dart';
import 'package:space_station_tycoon/redux/state/state.dart';
import 'package:space_station_tycoon/widgets/game_view.dart';
import 'package:space_station_tycoon/widgets/loading_overlay.dart';


@immutable
class GameController extends StatefulWidget {
  final FrameController frameController;

  GameController({
    @required this.frameController,
    Key key,
  }) : super(key: key);

  @override
  GameControllerState createState() => GameControllerState();
}

class GameControllerState extends State<GameController> {
  Store<GameState> store;

  GameControllerState() {
    store = Store<GameState>(
      gameStateReducer,
      initialState: GameStateScenarios.buildSimpleGameStateScenario(),
      middleware: buildGameStateMiddleware(
        visitorController: VisitorController(),
        moduleController: ModuleController(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<GameState>(
      store: store,
      child: StoreBuilder<GameState>(
        // todo: optomize so the scaffold doesn't rebuild here
       // rebuildOnChange: false,
        onInit: (Store<GameState> store) {
          widget.frameController.onFrame.listen((event) {
            store.dispatch(NextFrameAction());
          });

          store.dispatch(LoadAssetsAction());
        },
        onDispose: (Store<GameState> store) {
          widget.frameController.dispose();
        },
        builder: (BuildContext context, Store<GameState> store) => 
          LoadingOverlay(
            isLoading: store.state.assetState.isLoaded == false,
            child: GameView(),
          )
      ),
    );
  }
}