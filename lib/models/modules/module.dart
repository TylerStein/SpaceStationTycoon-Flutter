import 'package:flutter/foundation.dart' show immutable;
import 'package:redux/redux.dart';
import 'package:space_station_tycoon/models/id.dart';
import 'package:space_station_tycoon/models/visitors/visitor.dart';
import 'package:space_station_tycoon/redux/state/state.dart';

enum ModuleLocation {
  INTERIOR,
  EXTERIOR
}

class ModuleID {
  static int _index = 0;

  int id;
  ModuleID(this.id);

  @override
  int get hashCode => id.hashCode;

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is ModuleID &&
    other.id == this.id;

  @override
  String toString() => id.toString();

  factory ModuleID.unique() {
    return new ModuleID(ModuleID._index++);
  }
}


/// Flyweight representation of the module
/// This generic class defines all the common elements of a module
@immutable
abstract class ModuleTemplate {
  const ModuleTemplate(this.moduleLocation);

  final ModuleLocation moduleLocation;

  bool stationMeetsRequirements(Store<GameState> store);
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
  ID id;
  ModuleState(this.template);
  Type get templateType => T;
  void addSubmodule<K extends SubmoduleTemplate<T>>(SubmoduleState<K, T> submodule);
  List<SubmoduleState<K, T>> getSubmodules<K extends SubmoduleTemplate<T>>();
  bool hasSubmoduleOfType<K extends SubmoduleTemplate>() {
    return getSubmodules().firstWhere((element) => element.submoduleType == K, orElse: () => null) != null;
  }
  void updateModule(Store<GameState> store);
  int get submoduleCount;
}

@immutable
abstract class SubmoduleTemplate<T extends ModuleTemplate> {
  const SubmoduleTemplate();
  Type get parentType => T;
  String get shortName;
  int get baseCreditCost;
  bool parentModuleMeetsRequirements(Store<GameState> store, ModuleState<T> parent);
  SubmoduleState createDefaultState();
}

abstract class SubmoduleState<T extends SubmoduleTemplate<K>, K extends ModuleTemplate> {
  T template;
  SubmoduleState(this.template);
  Type get submoduleType => T;
  void updateSubmodule(Store<GameState> store, ModuleState<K> parent);
}

abstract class SingleVisitorModuleState {
  // bool get isOccupied;
  // ID get visitorID;
  void setVisitor(Visitor visitor);
  void removeVisitor();
}

// abstract class MultiVisitorModuleState {
//   bool get hasVisitors;
//   List<ID> get visitorIDs;
//   List<Visitor> get visitors;
//   void addVisitor(Visitor visitor);
//   void removeVisitor(ID visitorID);
// }