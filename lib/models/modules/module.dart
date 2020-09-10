import 'package:flutter/foundation.dart' show immutable;
import 'package:space_station_tycoon/game_loop.dart';
import 'package:space_station_tycoon/models/provider_models/visitor_model.dart';

enum ModuleLocation {
  INTERIOR,
  EXTERIOR
}

/// Flyweight representation of the module
/// This generic class defines all the common elements of a module
@immutable
abstract class ModuleTemplate {
  const ModuleTemplate(this.moduleLocation);

  final ModuleLocation moduleLocation;

  bool stationMeetsRequirements(GameLoopLogic game);
  ModuleState createDefaultState();
  String get shortName;
  int get baseCreditCost;
  int get baseModuleSlots;

  @override
  int get hashCode => this.runtimeType.hashCode;

  @override
  operator ==(Object other) => identical(this, other) || other is ModuleTemplate;
}

/// Implementation of module data
/// This includes all the unique aspects of an instantiated module
abstract class ModuleState<T extends ModuleTemplate> {
  T template;
  ModuleState(this.template);
  Type get templateType => T;
  void addSubmodule<K extends SubmoduleTemplate<T>>(SubmoduleState<K, T> submodule);
  List<SubmoduleState<K, T>> getSubmodules<K extends SubmoduleTemplate<T>>();
  bool hasSubmoduleOfType<K extends SubmoduleTemplate>() {
    return getSubmodules().firstWhere((element) => element.submoduleType == K, orElse: () => null) != null;
  }
  void updateModule(GameLoopLogic game);
  int get submoduleCount;
}

@immutable
abstract class SubmoduleTemplate<T extends ModuleTemplate> {
  const SubmoduleTemplate();
  Type get parentType => T;
  String get shortName;
  int get baseCreditCost;
  bool parentModuleMeetsRequirements(GameLoopLogic game, ModuleState<T> parent);
  SubmoduleState createDefaultState();
}

abstract class SubmoduleState<T extends SubmoduleTemplate<K>, K extends ModuleTemplate> {
  T template;
  SubmoduleState(this.template);
  Type get submoduleType => T;
  void updateSubmodule(GameLoopLogic game, ModuleState<K> parent);
}

abstract class SingleVisitorModuleState {
  bool get isOccupied;
  VisitorID get visitorID;
  void setVisitor(Visitor visitor);
  void removeVisitor();
}