import 'package:redux/redux.dart';
import 'package:space_station_tycoon/redux/actions/engine_actions.dart';
import 'package:space_station_tycoon/redux/actions/state_actions.dart';
import 'package:space_station_tycoon/redux/state/asset_state.dart';
import 'package:space_station_tycoon/redux/state/state.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:built_collection/built_collection.dart';

class AssetMiddleware {
  List<Middleware<GameState>> buildAll() => [
    TypedMiddleware<GameState, LoadAssetsAction>(buildHandleLoadAssetsAction()),
  ];

  buildHandleLoadAssetsAction() {
    return (Store<GameState> store, LoadAssetsAction action, NextDispatcher next) async {
      try {
        String loadedShipNames = await rootBundle.loadString('assets/lists/ship_names.txt');
        LineSplitter lineSplitter = LineSplitter();
        List<String> shipNames = lineSplitter.convert(loadedShipNames);
        BuiltList<String> shipNamesBuilt = BuiltList<String>.of(shipNames);
        store.dispatch(SetAssetStateAction(AssetState(shipNames: shipNamesBuilt, isLoaded: true)));
      } catch (error) {
        print(error);
        store.dispatch(SetAssetStateAction(AssetState(shipNames: BuiltList(), isLoaded: true)));
      }
    };
  }
}