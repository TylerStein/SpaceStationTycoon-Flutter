import 'package:space_station_tycoon/models/visitors/ship.dart';

class T1ShipTemplate extends ShipTemplate {
  T1ShipTemplate(
    List<ShipRequirementTemplate> requirementTemplates,
  ) : super(requirementTemplates);

  @override
  T1ShipState createDefaultState() => T1ShipState(
    this,
    requirementTemplates.map((template) => template.createDefaultState()).toList(),
  );
}

class T1ShipState extends ShipState<T1ShipTemplate> {
  T1ShipState(
    T1ShipTemplate parentTemplate,
    List<ShipRequirementState> requirementStates,
  ) : super(
    parentTemplate,
    requirementStates,
  );
}