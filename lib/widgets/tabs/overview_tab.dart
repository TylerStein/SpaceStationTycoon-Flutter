import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:space_station_tycoon/redux/state/state.dart';

@immutable
class OverviewTabViewModel {
  final String name;

  OverviewTabViewModel({
    @required this.name,
  });

  @override
  int get hashCode => name.hashCode;

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is OverviewTabViewModel &&
    other.name == name;

  factory OverviewTabViewModel.fromStore(Store<GameState> store) =>
    OverviewTabViewModel(
      name: store.state.metadataState.name,
    );
}

class OverviewTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<GameState, OverviewTabViewModel>(
      converter: (Store<GameState> store) => OverviewTabViewModel.fromStore(store),
      builder: (BuildContext context, OverviewTabViewModel viewModel) => 
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                viewModel.name,
                style: Theme.of(context).textTheme.headline4,
              )
            ),
          ],
      ),
    );
  }
}