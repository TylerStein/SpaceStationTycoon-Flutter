import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import 'package:space_station_tycoon/models/id.dart';
import 'package:space_station_tycoon/models/modules/module.dart';
import 'package:space_station_tycoon/models/modules/templates/dock_module.dart';
import 'package:space_station_tycoon/models/modules/templates/fueling_module.dart';
import 'package:space_station_tycoon/models/visitors/visitor.dart';
import 'package:space_station_tycoon/redux/actions/game_actions.dart';
import 'package:space_station_tycoon/redux/actions/state_actions.dart';
import 'package:space_station_tycoon/redux/state/state.dart';

abstract class VisitorNeed {
  int priority = 0;
  Visitor visitor;
  VisitorNeed({
    @required this.priority,
    @required this.visitor,
  });
  bool canBeFufilled(Store<GameState> store);
  bool tryOccupyModule(Store<GameState> store);
  void updateNeed(Store<GameState> store);
  bool get isFufilled;
}

class FuelingNeed extends VisitorNeed {
  int fuelCount;
  int fuelTier;
  FuelingSubmoduleState occupiedFuelingState;

  FuelingNeed({
    @required Visitor visitor,
    @required this.fuelTier,
    @required this.fuelCount,
    this.occupiedFuelingState,
  }) : super(
    priority: 999,
    visitor: visitor,
  );

  @override
  bool get isFufilled => fuelCount <= 0;

  @override
  bool canBeFufilled(Store<GameState> store) {
    List<ModuleState> openDocksWithFueling = store.state.moduleState.getModulesOfType<DockModuleTemplate>(testState: (ModuleState<DockModuleTemplate> moduleState) {
      DockModuleState dockState = moduleState as DockModuleState;
      bool hasFueling = dockState.hasSubmoduleOfType<FuelingSubmoduleTemplate>();
      Set<ID> moduleVisitors = store.state.moduleVisitorBindingState.getModuleVisitors(moduleState.id);
      return hasFueling && moduleVisitors.isEmpty;
    });

    return openDocksWithFueling.isNotEmpty;
  }

  @override
  bool tryOccupyModule(Store<GameState> store) {
    List<ModuleState> openDocksWithFueling = store.state.moduleState.getModulesOfType<DockModuleTemplate>(testState: (ModuleState<DockModuleTemplate> moduleState) {
      DockModuleState dockState = moduleState as DockModuleState;
      bool hasFueling = dockState.hasSubmoduleOfType<FuelingSubmoduleTemplate>();
      Set<ID> moduleVisitors = store.state.moduleVisitorBindingState.getModuleVisitors(moduleState.id);
      return hasFueling && moduleVisitors.isEmpty;
    });

    if (openDocksWithFueling.isNotEmpty) {
      DockModuleState dock = openDocksWithFueling.first as DockModuleState;
      occupiedFuelingState = dock.getSubmodules().firstWhere((element) => element is FuelingSubmoduleState);
      store.dispatch(AddVisitorModuleBindingAction(visitor.id, dock.id));
      return true;
    }

    return false;
  }

  @override
  void updateNeed(Store<GameState> store) {
    if (fuelCount > 0) {
      int providedFuel = occupiedFuelingState.requestFuel(store, fuelCount);
      if (providedFuel == 0) {
        visitor.updateSatisfaction(-1);
      } else {
        store.dispatch(SetResourceStateAction(
          store.state.resourceState.withAddCredits(providedFuel),
        ));
      }

      fuelCount -= providedFuel;
    }
  }
}
