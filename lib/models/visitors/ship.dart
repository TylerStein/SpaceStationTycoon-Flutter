import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import 'package:space_station_tycoon/models/modules/module.dart';
import 'package:space_station_tycoon/redux/state/state.dart';

@immutable
abstract class ShipTemplate {
  final List<ShipRequirementTemplate> requirementTemplates;
  const ShipTemplate(this.requirementTemplates);
  ShipState createDefaultState();

  @override
  int get hashCode => 0;

  @override
  operator ==(Object other) => identical(this, other) || other is ModuleTemplate;
}

abstract class ShipState<T extends ShipTemplate> {
  T template;
  List<ShipRequirementState> requirementStates;
  Type get parentType => T;
  ShipState(this.template, this.requirementStates);
}

@immutable
abstract class ShipRequirementTemplate {
  const ShipRequirementTemplate();

  bool modulesCanSatisfy(Store<GameState> store);
  ShipRequirementState createDefaultState();
}

abstract class ShipRequirementState<T extends ShipRequirementTemplate> {
  T template;
  ShipRequirementState(this.template);
  bool get isSatisfied;
}