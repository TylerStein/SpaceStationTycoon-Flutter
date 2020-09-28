import 'package:redux/redux.dart';
import 'package:space_station_tycoon/models/modules/module.dart';
import 'package:space_station_tycoon/models/modules/templates/dock_module.dart';
import 'package:space_station_tycoon/redux/actions/resource_actions.dart';
import 'package:space_station_tycoon/redux/state/state.dart';

class RepairSubmoduleTemplate extends SubmoduleTemplate<DockModuleTemplate> {
  const RepairSubmoduleTemplate() : super();

  @override
  String get shortName => 'REPAIR';

  @override
  int get baseCreditCost => 500;

  @override
  bool parentModuleMeetsRequirements(Store<GameState> store, ModuleState<DockModuleTemplate> parent) {
    return (parent.submoduleCount + 1) <= parent.template.baseModuleSlots
      && store.state.resourceState.credits.value >= baseCreditCost;
  }

  @override
  RepairSubmoduleState createDefaultState() => RepairSubmoduleState(this);
}

class RepairSubmoduleState extends SubmoduleState<RepairSubmoduleTemplate, DockModuleTemplate> {
  RepairSubmoduleState(
    RepairSubmoduleTemplate template
  ) : super(template);
  
  void updateSubmodule(Store<GameState> store, ModuleState<DockModuleTemplate> parent) {
    //
  }

  int requestParts(Store<GameState> store, int count) {
    int partsBefore = store.state.resourceState.repairParts.value;
    store.dispatch(SetResourceStateAction(
      store.state.resourceState.withAddRepairParts(-1 * count),
    ));
    return partsBefore - store.state.resourceState.repairParts.value;
  }
}