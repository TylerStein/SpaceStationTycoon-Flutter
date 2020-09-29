import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import 'package:space_station_tycoon/models/modules/module.dart';
import 'package:space_station_tycoon/models/modules/templates/dock_module.dart';
import 'package:space_station_tycoon/models/modules/templates/fueling_module.dart';
import 'package:space_station_tycoon/redux/actions/state_actions.dart';
import 'package:space_station_tycoon/redux/state/state.dart';
import 'package:space_station_tycoon/redux/state/visitor_state.dart';

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
      return dockState.hasSubmoduleOfType<FuelingSubmoduleTemplate>() &&
          dockState.isOccupied == false;
    });

    return openDocksWithFueling.isNotEmpty;
  }

  @override
  bool tryOccupyModule(Store<GameState> store) {
    List<ModuleState> openDocksWithFueling = store.state.moduleState.getModulesOfType<DockModuleTemplate>(testState: (ModuleState<DockModuleTemplate> moduleState) {
      DockModuleState dockState = moduleState as DockModuleState;
      return dockState.hasSubmoduleOfType<FuelingSubmoduleTemplate>() &&
          dockState.isOccupied == false;
    });

    if (visitor.occupyingModule != null && visitor.occupyingModule.isOccupied) {
      visitor.occupyingModule.removeVisitor();
    }

    for (ModuleState moduleState in openDocksWithFueling) {
      DockModuleState dock = moduleState as DockModuleState;
      if (dock.isOccupied) continue;
      dock.visitorID = visitor.id;
      visitor.occupyingModule = moduleState as SingleVisitorModuleState;
      occupiedFuelingState = (moduleState as DockModuleState).getSubmodules().firstWhere((element) => element is FuelingSubmoduleState);

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
