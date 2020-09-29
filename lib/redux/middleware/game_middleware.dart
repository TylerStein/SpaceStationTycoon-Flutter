import 'package:redux/redux.dart';
import 'package:space_station_tycoon/redux/actions/engine_actions.dart';
import 'package:space_station_tycoon/redux/actions/state_actions.dart';
import 'package:space_station_tycoon/redux/actions/game_actions.dart';
import 'package:space_station_tycoon/redux/actions/generic_actions.dart';
import 'package:space_station_tycoon/redux/state/state.dart';

class TimeMiddleware {
  List<Middleware<GameState>> buildAll() => [
    TypedMiddleware<GameState, LoggableAction>(buildHandleLoggableAction()),
    TypedMiddleware<GameState, NextFrameAction>(buildHandleNextFrameAction()),
  ];

  buildHandleLoggableAction() {
    return (Store<GameState> store, LoggableAction action, NextDispatcher next) async {
      store.dispatch(
        SetMetadataStateAction(
          store.state.metadataState.withAddedLog(action.logEvent),
        )
      );
    };
  }

  buildHandleNextFrameAction() {
    return (Store<GameState> store, NextFrameAction action, NextDispatcher next) async {
      int newFrameValue = store.state.timeState.frame;
      store.dispatch(
        SetTimeStateAction(
          store.state.timeState.copyWith(
            frame: newFrameValue,
          )
        )
      );
    };
  }

  updateModules(Store<GameState> store, int frame) {
    store.state.moduleState.interiorModules.forEach((element) {
      store.dispatch(RunModuleLogicAction(element));
    });

    store.state.moduleState.exteriorModules.forEach((element) {
      store.dispatch(RunModuleLogicAction(element));
    });
  }

  updateVisitors(Store<GameState> store, int frame) {
    store.state.visitorState.visitors.values.forEach((element) {
      store.dispatch(RunVisitorLogicAction(element));
    });
  }

  updateWorld(Store<GameState> store, int frame) {
    if (store.state.visitorState.visitors.isEmpty) {
      store.dispatch(GenerateVisitorAction());
    }
  }

  updateMetadata(Store<GameState> store, int frame) {
      store.dispatch(
        SetMetadataStateAction(
          store.state.metadataState.copyWith(
            day: store.state.metadataState.day + 1,
          ),
        ),
      );
  }
}