import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:space_station_tycoon/redux/state/state.dart';

@immutable
class QuestTabViewModel {
  QuestTabViewModel();

  @override
  int get hashCode => 0;

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is QuestTabViewModel;

  factory QuestTabViewModel.fromStore(Store<GameState> store) =>
    QuestTabViewModel();
}

class QuestTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<GameState, QuestTabViewModel>(
      converter: (Store<GameState> store) => QuestTabViewModel(),
      builder: (BuildContext context, QuestTabViewModel viewModel) => 
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                'Quests',
                style: Theme.of(context).textTheme.headline4,
              )
            ),
          ],
      ),
    );
  }
}