import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:space_station_tycoon/redux/state/state.dart';

@immutable
class SettingsTabViewModel {
  SettingsTabViewModel();

  @override
  int get hashCode => 0;

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is SettingsTabViewModel;

  factory SettingsTabViewModel.fromStore(Store<GameState> store) =>
    SettingsTabViewModel();
}
class SettingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<GameState, SettingsTabViewModel>(
      converter: (Store<GameState> store) => SettingsTabViewModel.fromStore(store),
      builder: (BuildContext context, SettingsTabViewModel viewModel) => 
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                'Settings',
                style: Theme.of(context).textTheme.headline4,
              )
            ),
          ],
      ),
    );
  }
}