import 'package:redux/redux.dart';
import 'package:space_station_tycoon/redux/actions/metadata_actions.dart';
import 'package:space_station_tycoon/redux/actions/time_actions.dart';
import 'package:space_station_tycoon/redux/state/state.dart';

class TimeMiddleware {
  List<Middleware<GameState>> buildAll() => [
    TypedMiddleware<GameState, NextFrameAction>(buildHandleNextFrameAction()),
  ];

  buildHandleNextFrameAction() {
    return (Store<GameState> store, NextFrameAction action, NextDispatcher next) async {
      print('New frame!');
      int newFrameValue = store.state.timeState.frame;
      store.dispatch(
        SetTimeStateAction(
          store.state.timeState.copyWith(
            frame: newFrameValue,
          )
        )
      );

      store.dispatch(
        SetMetadataStateAction(
          store.state.metadataState.copyWith(
            day: store.state.metadataState.day + 1,
          ),
        ),
      );
    };
  }
}