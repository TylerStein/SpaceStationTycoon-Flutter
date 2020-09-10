import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:space_station_tycoon/game_loop.dart';
import 'package:space_station_tycoon/theme.dart';
import 'package:space_station_tycoon/widgets/game_view.dart';
import 'package:space_station_tycoon/widgets/handlers/building_handler.dart';
import 'package:space_station_tycoon/widgets/providers/metadata_provider.dart';
import 'package:space_station_tycoon/widgets/providers/modules_provider.dart';
import 'package:space_station_tycoon/widgets/providers/resources_provider.dart';
import 'package:space_station_tycoon/widgets/providers/tick_provider.dart';
import 'package:space_station_tycoon/widgets/providers/unlocks_provider.dart';
import 'package:space_station_tycoon/widgets/providers/visitors_provider.dart';

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
  Game({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => MetadataProvider.createDefault(context)),
          ChangeNotifierProvider(create: (context) => ModulesProvider.createDefault(context)),
          ChangeNotifierProvider(create: (context) => ResourcesProvider.createDefault(context)),
          ChangeNotifierProvider(create: (context) => UnlocksProvider.createDefault(context)),
          ChangeNotifierProvider(create: (context) => VisitorsProvider.createDefault(context)),
        ],
        child: TickProvider(
          tickState: TickState(duration: Duration(seconds: 1), frame: 0),
          child: Builder(
            builder: (context) =>
              Consumer5<MetadataProvider, ModulesProvider, ResourcesProvider, UnlocksProvider, VisitorsProvider>(
                child: GameView(),
                builder: (
                  BuildContext context,
                  MetadataProvider metadataProvidr,
                  ModulesProvider modulesProvider,
                  ResourcesProvider resourcesProvider,
                  UnlocksProvider unlocksProvider,
                  VisitorsProvider visitorsProvider,
                  Widget child,
                ) => MultiProvider(
                  child: GameLoopLogic(
                    child: child,
                    tickProvider: TickProvider.of(context),
                    metadataProvider: metadataProvidr,
                    resourcesProvider: resourcesProvider,
                    visitorsProvider: visitorsProvider,
                    modulesProvider: modulesProvider,
                    // unlocksProvider: unlocksProvider,
                    // visitorProvider: visitorsProvider,
                  ),
                  providers: [
                    ChangeNotifierProvider(
                      create: (BuildContext context) => BuildInteractionProvider(
                        modulesProvider: modulesProvider,
                        unlocksProvider: unlocksProvider,
                        resourcesProvider: resourcesProvider,
                      ),
                    ),
                  ],
                ),
              ),
          ),
        ),
    );
  }
}
