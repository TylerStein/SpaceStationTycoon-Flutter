import 'package:redux/redux.dart';
import 'package:space_station_tycoon/models/modules/module.dart';
import 'package:space_station_tycoon/models/modules/templates.dart';
import 'package:space_station_tycoon/models/visitors/ship.dart';
import 'package:space_station_tycoon/redux/state/state.dart';

class FuelShipRequirementTemplate extends ShipRequirementTemplate {
  @override
  bool modulesCanSatisfy(Store<GameState> store) {
    List<DockModuleState> moduleStates = store.state.moduleState.getModulesOfType<DockModuleTemplate>(
      testState: (ModuleState<DockModuleTemplate> state) =>
        state.hasSubmoduleOfType<FuelingSubmoduleTemplate>(),
    ) as List<DockModuleState>;

    return moduleStates.isNotEmpty;
  }

  @override
  FuelShipRequirementState createDefaultState() =>
    FuelShipRequirementState(this);
}

class FuelShipRequirementState extends ShipRequirementState<FuelShipRequirementTemplate> {
  FuelShipRequirementState(FuelShipRequirementTemplate template) : super(template);

  @override
  bool get isSatisfied => true;
}