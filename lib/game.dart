import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:space_station_tycoon/frame_controller.dart';
import 'package:space_station_tycoon/redux/actions/engine_actions.dart';
import 'package:space_station_tycoon/redux/middleware/middleware.dart';
import 'package:space_station_tycoon/redux/reducers/reducer.dart';
import 'package:space_station_tycoon/redux/state/state.dart';
import 'package:space_station_tycoon/widgets/game_view.dart';


@immutable
class Game extends StatelessWidget {
  final FrameController frameController;

  Game({
    @required this.frameController,
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return StoreProvider<GameState>(
      store: Store<GameState>(
        gameStateReducer,
        initialState: GameState.createDefault(),
        middleware: buildGameStateMiddleware(),
      ),
      child: StoreBuilder<GameState>(
        onInit: (Store<GameState> store) {
          frameController.onFrame.listen((event) {
            store.dispatch(NextFrameAction());
          });
        },
        onDispose: (Store<GameState> store) {
          frameController.dispose();
        },
        builder: (BuildContext context, Store<GameState> store) => GameView(),
      ),
    );
  }
}