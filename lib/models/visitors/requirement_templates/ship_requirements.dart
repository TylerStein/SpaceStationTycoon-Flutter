import 'package:space_station_tycoon/models/modules/module.dart';
import 'package:space_station_tycoon/models/modules/templates.dart';
import 'package:space_station_tycoon/models/visitors/ship.dart';
import 'package:space_station_tycoon/widgets/providers/modules_provider.dart';

class FuelShipRequirementTemplate extends ShipRequirementTemplate {
  @override
  bool modulesCanSatisfy(ModulesProvider modulesProvider) {
    List<DockModuleState> moduleStates = modulesProvider.getModulesOfType<DockModuleTemplate>(
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