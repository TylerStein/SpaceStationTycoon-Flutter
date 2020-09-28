import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:space_station_tycoon/redux/state/state.dart';
import 'package:space_station_tycoon/redux/state/visitor_state.dart';
import 'package:space_station_tycoon/widgets/tabs/visitors_tab/visitor_card.dart';


class VisitorsTabViewModel {
  BuiltList<Visitor> visitors;

  VisitorsTabViewModel({
    @required this.visitors,
  });

  @override
  int get hashCode => visitors.hashCode;

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is VisitorsTabViewModel &&
    other.visitors == visitors;

  factory VisitorsTabViewModel.fromStore(Store<GameState> store) =>
    VisitorsTabViewModel(
      visitors: store.state.visitorState.visitors.values.toBuiltList(),
    );
}

class VisitorsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<GameState, VisitorsTabViewModel>(
      converter: (Store<GameState> store) => VisitorsTabViewModel.fromStore(store),
      builder: (BuildContext context, VisitorsTabViewModel viewModel) =>
        ListView.builder(
          itemCount: viewModel.visitors.length,
          itemBuilder: (BuildContext context, int index) =>
            VisitorCard(visitor: viewModel.visitors[index])
        ),
    );
  }
}