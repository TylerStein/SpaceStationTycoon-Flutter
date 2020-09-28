import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:space_station_tycoon/redux/middleware/middleware.dart';
import 'package:space_station_tycoon/redux/reducers/reducer.dart';
import 'package:space_station_tycoon/redux/state/state.dart';
import 'package:space_station_tycoon/theme.dart';
import 'package:space_station_tycoon/widgets/game_view.dart';


void main() {
  runApp(App());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: SpaceStationTycoonTheme.darkThemeData.appBarTheme.color,
    statusBarBrightness: Brightness.dark,
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: ValueKey('root'),
      title: 'Space Station Tycoon',
      theme: SpaceStationTycoonTheme.darkThemeData,
      darkTheme: SpaceStationTycoonTheme.darkThemeData,
      themeMode: ThemeMode.dark,
      home: Game(),
    );
  }
}

class Game extends StatelessWidget {
  Game({
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
      child: GameView(),
    );
    
    // return MultiProvider(
    //     providers: [
    //       ChangeNotifierProvider(create: (context) => MetadataProvider.createDefault(context)),
    //       ChangeNotifierProvider(create: (context) => ModulesProvider.createDefault(context)),
    //       ChangeNotifierProvider(create: (context) => ResourcesProvider.createDefault(context)),
    //       ChangeNotifierProvider(create: (context) => UnlocksProvider.createDefault(context)),
    //       ChangeNotifierProvider(create: (context) => VisitorsProvider.createDefault(context)),
    //       ChangeNotifierProvider(create: (context) => AssetProvider.createDefault(context)),
    //     ],
    //     child: TickProvider(
    //       tickState: TickState(duration: Duration(seconds: 1), frame: 0),
    //       child: Builder(
    //         builder: (context) =>
    //           Consumer6<MetadataProvider, ModulesProvider, ResourcesProvider, UnlocksProvider, VisitorsProvider, AssetProvider>(
    //             child: GameView(),
    //             builder: (
    //               BuildContext context,
    //               MetadataProvider metadataProvidr,
    //               ModulesProvider modulesProvider,
    //               ResourcesProvider resourcesProvider,
    //               UnlocksProvider unlocksProvider,
    //               VisitorsProvider visitorsProvider,
    //               AssetProvider assetProvider,
    //               Widget child,
    //             ) => MultiProvider(
    //               child: GameLoopLogic(
    //                 child: child,
    //                 tickProvider: TickProvider.of(context),
    //                 metadataProvider: metadataProvidr,
    //                 resourcesProvider: resourcesProvider,
    //                 visitorsProvider: visitorsProvider,
    //                 modulesProvider: modulesProvider,
    //                 assetProvider: assetProvider,
    //                 // unlocksProvider: unlocksProvider,
    //                 // visitorProvider: visitorsProvider,
    //               ),
    //               providers: [
    //                 ChangeNotifierProvider(
    //                   create: (BuildContext context) => BuildInteractionProvider(
    //                     modulesProvider: modulesProvider,
    //                     unlocksProvider: unlocksProvider,
    //                     resourcesProvider: resourcesProvider,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //       ),
    //     ),
    // );
  }
}
