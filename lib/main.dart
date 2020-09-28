import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:space_station_tycoon/frame_controller.dart';
import 'package:space_station_tycoon/game.dart';
import 'package:space_station_tycoon/theme.dart';

StreamController gameTickController;

void main() {
  FrameController frameController = FrameController(
    const Duration(seconds: 1),
  );

  runApp(App(frameController: frameController,));
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: SpaceStationTycoonTheme.darkThemeData.appBarTheme.color,
    statusBarBrightness: Brightness.dark,
  ));
}

class App extends StatelessWidget {
  final FrameController frameController;

  App({
    @required this.frameController
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: ValueKey('root'),
      title: 'Space Station Tycoon',
      theme: SpaceStationTycoonTheme.darkThemeData,
      darkTheme: SpaceStationTycoonTheme.darkThemeData,
      themeMode: ThemeMode.dark,
      home: Game(
        frameController: frameController,
      ),
    );
  }
}

    
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