import 'package:flutter/material.dart';
import 'package:space_station_tycoon/widgets/game_tabs.dart';
import 'package:space_station_tycoon/widgets/quick_bar.dart';

class GameView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            QuickBar(),
            Expanded(
              child: GameTabs(),
            ),
          ],
        ),
      )
    );
  }
}