import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:space_station_tycoon/redux/state/state.dart';
import 'package:space_station_tycoon/widgets/tabs/economy_tab/resource_card.dart';
import 'package:space_station_tycoon/redux/actions/state_actions.dart';

@immutable
class EconomyTabViewModel {
  final int credits;
  final int creditsDifference;
  final int fuel;
  final int fuelDifference;

  final Function(int) addCredits;
  final Function(int) addFuel;

  EconomyTabViewModel({
    @required this.credits,
    @required this.creditsDifference,
    @required this.fuel,
    @required this.fuelDifference,
    @required this.addCredits,
    @required this.addFuel,
  });

  @override
  int get hashCode => 
    credits.hashCode ^
    creditsDifference.hashCode ^
    fuel.hashCode ^
    fuelDifference.hashCode;

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is EconomyTabViewModel &&
    other.credits == credits &&
    other.creditsDifference == creditsDifference &&
    other.fuel == fuel &&
    other.fuelDifference == fuelDifference;

  factory EconomyTabViewModel.fromStore(Store<GameState> store) =>
    EconomyTabViewModel(
      credits: store.state.resourceState.credits.value,
      creditsDifference: store.state.resourceState.credits.last - store.state.resourceState.credits.value,
      fuel: store.state.resourceState.fuel.value,
      fuelDifference: store.state.resourceState.fuel.last - store.state.resourceState.fuel.value,
      addCredits: (int credits) {
        store.dispatch(SetResourceStateAction(store.state.resourceState.withAddCredits(credits)));
      },
      addFuel: (int fuel) {
        store.dispatch(SetResourceStateAction(store.state.resourceState.withAddFuel(fuel)));
      }
    );
}

class EconomyTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<GameState, EconomyTabViewModel>(
      converter: (Store<GameState> store) => EconomyTabViewModel.fromStore(store),
      builder: (BuildContext context, EconomyTabViewModel viewModel) => 
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ResourceCard(
              label: 'Credits',
              currentValue: viewModel.credits,
              lastValueChange: viewModel.creditsDifference,
              onTap: () {
                viewModel.addCredits(10);
              },
            ),
            ResourceCard(
              label: 'Fuel',
              currentValue: viewModel.fuel,
              lastValueChange: viewModel.fuelDifference,
              onTap: () {
                viewModel.addFuel(10);
              },
            ),
          ],
      ),
    );
  }
}