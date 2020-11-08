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
      home: GameController(
        frameController: frameController,
      ),
    );
  }
}