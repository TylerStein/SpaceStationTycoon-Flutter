import 'package:flutter/foundation.dart';
import 'package:space_station_tycoon/game_loop.dart';
import 'package:space_station_tycoon/models/modules/module.dart';
import 'package:space_station_tycoon/models/modules/templates/dock_module.dart';
import 'package:space_station_tycoon/models/modules/templates/fueling_module.dart';
import 'package:space_station_tycoon/models/provider_models/visitor_model.dart';

abstract class VisitorNeed {
  int priority = 0;
  Visitor visitor;
  VisitorNeed({
    @required this.priority,
    @required this.visitor,
  });
  bool canBeFufilled(GameLoopLogic game);
  bool tryOccupyModule(GameLoopLogic game);
  void updateNeed(GameLoopLogic game);
  bool get isFufilled;
}

class FuelingNeed extends VisitorNeed {
  int fuelCount;
  int fuelTier;

  FuelingNeed({
    @required Visitor visitor,
    @required this.fuelTier,
    @required this.fuelCount,
  }) : super(
    priority: 999,
    visitor: visitor,
  );

  @override
  bool get isFufilled => fuelCount > 0;

  @override
  bool canBeFufilled(GameLoopLogic game) {
    List<ModuleState> openDocksWithFueling = game.modulesProvider
        .getModulesOfType<DockModuleTemplate>(
            testState: (ModuleState<DockModuleTemplate> moduleState) {
      DockModuleState dockState = moduleState as DockModuleState;
      return dockState.hasSubmoduleOfType<FuelingSubmoduleTemplate>() &&
          dockState.isNotOccupied;
    });

    return openDocksWithFueling.isNotEmpty;
  }

  @override
  bool tryOccupyModule(GameLoopLogic game) {
    List<ModuleState> openDocksWithFueling = game.modulesProvider
        .getModulesOfType<DockModuleTemplate>(
            testState: (ModuleState<DockModuleTemplate> moduleState) {
      DockModuleState dockState = moduleState as DockModuleState;
      return dockState.hasSubmoduleOfType<FuelingSubmoduleTemplate>() &&
          dockState.isNotOccupied;
    });

    bool removed = visitor.occupyingModule.removeVisitor(visitor.id);
    if (!removed) return false;

    for (ModuleState moduleState in openDocksWithFueling) {
      DockModuleState dock = moduleState as DockModuleState;
      if (dock.isOccupied) continue;
      dock.visitorID = visitor.id;
      visitor.occupyingModule = moduleState;
      return true;
    }

    return false;
  }

  @override
  void updateNeed(GameLoopLogic game) {

  }
}
