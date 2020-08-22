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

  bool stationMeetsRequirements(dynamic station);
  ModuleState createDefaultState();
  String get shortName;
  int get baseCreditCost;

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
  Type get templateType => T.runtimeType;
  void addSubmodule<K extends SubmoduleTemplate<T>>(SubmoduleState<K> submodule);
  List<SubmoduleState<K>> getSubmodules<K extends SubmoduleTemplate<T>>();
  bool hasSubmoduleOfType<K extends SubmoduleTemplate>() {
    Type submoduleType = K.runtimeType;
    return getSubmodules().firstWhere((element) => element.submoduleType == submoduleType, orElse: () => null) != null;
  }
  void updateModule(GameLoopLogic game);
  bool removeVisitor(VisitorID visitorID);
}

@immutable
abstract class SubmoduleTemplate<T extends ModuleTemplate> {
  const SubmoduleTemplate();
  Type get parentType => T.runtimeType;
  String get shortName;
  int get baseCreditCost;
  bool parentModuleMeetsRequirements(T parent);
  SubmoduleState createDefaultState();
}

abstract class SubmoduleState<T extends SubmoduleTemplate> {
  T template;
  SubmoduleState(this.template);
  Type get submoduleType => T.runtimeType;
  void updateSubmodule(GameLoopLogic game);
}