import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:space_station_tycoon/models/id.dart';
import 'package:space_station_tycoon/models/modules/module.dart';
import 'package:space_station_tycoon/models/visitors/visitor.dart';
import 'package:space_station_tycoon/redux/state/state.dart';
import 'package:space_station_tycoon/widgets/tabs/visitors_tab/visitor_card.dart';


class VisitorsTabViewModel {
  BuiltMap<Visitor, BuiltList<ModuleState>> visitorModules;

  VisitorsTabViewModel({
    @required this.visitorModules,
  });

  @override
  int get hashCode => visitorModules.hashCode;

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is VisitorsTabViewModel &&
    other.visitorModules == visitorModules;

  factory VisitorsTabViewModel.fromStore(Store<GameState> store) {
    MapBuilder<Visitor, BuiltList<ModuleState>> mapBuilder = MapBuilder<Visitor, BuiltList<ModuleState>>();
    for (Visitor visitor in store.state.visitorState.visitors.values) {
      ListBuilder<ModuleState> listBuilder = ListBuilder<ModuleState>();
      Set<ID> moduleIds = store.state.moduleVisitorBindingState.getVisitorModules(visitor.id);
      listBuilder.addAll(store.state.moduleState.interiorModules.where((element) => moduleIds.contains(element.id)));
      listBuilder.addAll(store.state.moduleState.exteriorModules.where((element) => moduleIds.contains(element.id)).toList());
      mapBuilder[visitor] = listBuilder.build();
    }

    return VisitorsTabViewModel(visitorModules: mapBuilder.build());
  }
}

class VisitorsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<GameState, VisitorsTabViewModel>(
      converter: (Store<GameState> store) => VisitorsTabViewModel.fromStore(store),
      builder: (BuildContext context, VisitorsTabViewModel viewModel) =>
        ListView.builder(
          itemCount: viewModel.visitorModules.length,
          itemBuilder: (BuildContext context, int index) =>
            VisitorCard(
              visitor: viewModel.visitorModules.keys.elementAt(index),
              modules: viewModel.visitorModules.values.elementAt(index),
            ),
        ),
    );
  }
}