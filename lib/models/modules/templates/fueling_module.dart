import 'package:space_station_tycoon/game_loop.dart';
import 'package:space_station_tycoon/models/modules/module.dart';
import 'package:space_station_tycoon/models/modules/templates/dock_module.dart';

class FuelingSubmoduleTemplate extends SubmoduleTemplate<DockModuleTemplate> {
  const FuelingSubmoduleTemplate() : super();

  @override
  String get shortName => 'FUELING';

  @override
  int get baseCreditCost => 500;

  @override
  bool parentModuleMeetsRequirements(GameLoopLogic game, ModuleState<DockModuleTemplate> parent) {
    return (parent.submoduleCount + 1) <= parent.template.baseModuleSlots
      && game.resourcesProvider.credits >= baseCreditCost;
  }

  @override
  FuelingSubmoduleState createDefaultState() => FuelingSubmoduleState(this);
}

class FuelingSubmoduleState extends SubmoduleState<FuelingSubmoduleTemplate, DockModuleTemplate> {
  FuelingSubmoduleState(
    FuelingSubmoduleTemplate template
  ) : super(template);
  
  void updateSubmodule(GameLoopLogic game, ModuleState<DockModuleTemplate> parent) {
    //
  }

  int requestFuel(GameLoopLogic game, int count) {
    int fuelBefore = game.resourcesProvider.fuel;
    game.resourcesProvider.addFuel(-count, false);
    return fuelBefore - game.resourcesProvider.fuel;
  }
}