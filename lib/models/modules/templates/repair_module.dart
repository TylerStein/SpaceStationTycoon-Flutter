import 'package:space_station_tycoon/game_loop.dart';
import 'package:space_station_tycoon/models/modules/module.dart';
import 'package:space_station_tycoon/models/modules/templates/dock_module.dart';

class RepairSubmoduleTemplate extends SubmoduleTemplate<DockModuleTemplate> {
  const RepairSubmoduleTemplate() : super();

  @override
  String get shortName => 'REPAIR';

  @override
  int get baseCreditCost => 500;

  @override
  bool parentModuleMeetsRequirements(GameLoopLogic game, ModuleState<DockModuleTemplate> parent) {
    return (parent.submoduleCount + 1) <= parent.template.baseModuleSlots
      && game.resourcesProvider.credits >= baseCreditCost;
  }

  @override
  RepairSubmoduleState createDefaultState() => RepairSubmoduleState(this);
}

class RepairSubmoduleState extends SubmoduleState<RepairSubmoduleTemplate, DockModuleTemplate> {
  RepairSubmoduleState(
    RepairSubmoduleTemplate template
  ) : super(template);
  
  void updateSubmodule(GameLoopLogic game, ModuleState<DockModuleTemplate> parent) {
    //
  }

  int requestParts(GameLoopLogic game, int count) {
    int partsBefore = game.resourcesProvider.repairParts;
    game.resourcesProvider.addRepairParts(-count, false);
    return partsBefore - game.resourcesProvider.repairParts;
  }
}