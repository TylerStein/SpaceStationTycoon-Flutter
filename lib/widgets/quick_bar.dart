import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:redux/redux.dart';
import 'package:space_station_tycoon/redux/state/state.dart';

@immutable
class QuickBarViewModel {
  final int credits;
  final int day;
  final int fuel;
  final int goods;
  final int parts;

  QuickBarViewModel({
    @required this.credits,
    @required this.day,
    @required this.fuel,
    @required this.goods,
    @required this.parts,
  });

  @override
  int get hashCode =>
    credits.hashCode ^
    day.hashCode ^
    fuel.hashCode ^
    goods.hashCode ^
    parts.hashCode;

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is QuickBarViewModel &&
    other.credits == credits &&
    other.day == day &&
    other.fuel == fuel &&
    other.goods == goods &&
    other.parts == parts;

  factory QuickBarViewModel.fromStore(Store<GameState> store) =>
    QuickBarViewModel(
      credits: store.state.resourceState.credits.value,
      day: store.state.metadataState.day,
      fuel: store.state.resourceState.fuel.value,
      goods: store.state.resourceState.consumerGoods.value,
      parts: store.state.resourceState.repairParts.value,
    );
    
}

class QuickBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<GameState, QuickBarViewModel>(
      converter: (Store<GameState> store) => QuickBarViewModel.fromStore(store),
      builder: (BuildContext context, QuickBarViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Day
            Icon(Icons.calendar_today, size: 12),
            Text(viewModel.day.toString()),
            Spacer(),
            // Credits
            Icon(Icons.attach_money, size: 12),
            Text(viewModel.credits.toString()),
            Spacer(),
            // Fuel
            Icon(Icons.local_gas_station, size: 12),
            Text(viewModel.fuel.toString()),
            Spacer(),
            // Parts
            Icon(FontAwesome.wrench, size: 12),
            Text(viewModel.parts.toString()),
            Spacer(),
            // Goods
            Icon(Icons.shopping_cart, size: 12),
            Text(viewModel.goods.toString()),
          ],
        ),
      ),
    );
  }
}