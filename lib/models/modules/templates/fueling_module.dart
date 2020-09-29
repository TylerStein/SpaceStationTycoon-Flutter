import 'package:redux/redux.dart';
import 'package:space_station_tycoon/models/modules/module.dart';
import 'package:space_station_tycoon/models/modules/templates/dock_module.dart';
import 'package:space_station_tycoon/redux/actions/state_actions.dart';
import 'package:space_station_tycoon/redux/state/state.dart';

class FuelingSubmoduleTemplate extends SubmoduleTemplate<DockModuleTemplate> {
  const FuelingSubmoduleTemplate() : super();

  @override
  String get shortName => 'FUELING';

  @override
  int get baseCreditCost => 500;

  @override
  bool parentModuleMeetsRequirements(Store<GameState> store, ModuleState<DockModuleTemplate> parent) {
    return (parent.submoduleCount + 1) <= parent.template.baseModuleSlots
      && store.state.resourceState.credits.value >= baseCreditCost;
  }

  @override
  FuelingSubmoduleState createDefaultState() => FuelingSubmoduleState(this);
}

class FuelingSubmoduleState extends SubmoduleState<FuelingSubmoduleTemplate, DockModuleTemplate> {
  FuelingSubmoduleState(
    FuelingSubmoduleTemplate template
  ) : super(template);
  
  void updateSubmodule(Store<GameState> store, ModuleState<DockModuleTemplate> parent) {
    //
  }

  int requestFuel(Store<GameState> store, int count) {
    int fuelBefore = store.state.resourceState.fuel.value;
    store.dispatch(SetResourceStateAction(
      store.state.resourceState.withAddFuel(-1 * count),
    ));
    return fuelBefore - store.state.resourceState.fuel.value;
  }
}