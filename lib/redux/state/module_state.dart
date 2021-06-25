import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:space_station_tycoon/models/modules/module.dart';
import 'package:space_station_tycoon/models/modules/module_factory.dart';

@immutable
class BuiltModulesState {
  final int maxInteriorModules;
  final int maxExteriormodules;
  final ModuleStateTree moduleStateTree;

  BuiltList<ModuleState> get interiorModules => moduleStateTree.interiorModules;
  BuiltList<ModuleState> get exteriorModules => moduleStateTree.exteriorModules;

  BuiltModulesState({
    @required this.maxInteriorModules,
    @required this.maxExteriormodules,
    @required this.moduleStateTree,
  });

  BuiltModulesState copyWith({
    int maxInteriorModules,
    int maxExteriormodules,
    ModuleStateTree moduleStateTree,
  }) =>
      BuiltModulesState(
        maxInteriorModules: maxInteriorModules ?? this.maxInteriorModules,
        maxExteriormodules: maxExteriormodules ?? this.maxExteriormodules,
        moduleStateTree: moduleStateTree ?? this.moduleStateTree,
      );

  factory BuiltModulesState.createDefault() => BuiltModulesState(
        maxInteriorModules: 0,
        maxExteriormodules: 0,
        moduleStateTree: ModuleStateTree(),
      );

  bool hasModuleByType(Type type) {
    ModuleLocation location =
        ModuleFactory.getModuleTemplateByType(type).moduleLocation;
    if (location == ModuleLocation.INTERIOR) {
      for (ModuleState state in moduleStateTree.interiorModules) {
        if (state.templateType == type) {
          return true;
        }
      }
    } else {
      for (ModuleState state in moduleStateTree.exteriorModules) {
        if (state.templateType == type) {
            return true;
        }
      }
    }

    return false;
  }

  bool hasModuleOfType<T extends ModuleTemplate>({
    bool Function(ModuleState<T> state) testState,
  }) {
    ModuleLocation location =
        ModuleFactory.getModuleTemplate<T>().moduleLocation;
    if (location == ModuleLocation.INTERIOR) {
      for (ModuleState state in moduleStateTree.interiorModules) {
        if (state.templateType == T) {
          if (testState != null) {
            return testState(state);
          } else {
            return true;
          }
        }
      }
    } else {
      for (ModuleState state in moduleStateTree.exteriorModules) {
        if (state.templateType == T) {
          if (testState != null) {
            return testState(state);
          } else {
            return true;
          }
        }
      }
    }

    return false;
  }

  List<ModuleState<T>> getModulesOfType<T extends ModuleTemplate>({
    bool Function(ModuleState<T> state) testState,
  }) {
    ModuleLocation location =
        ModuleFactory.getModuleTemplate<T>().moduleLocation;
    if (location == ModuleLocation.INTERIOR) {
      return moduleStateTree.interiorModules.where((ModuleState state) {
        if (state.templateType == T) {
          if (testState != null) {
            return testState(state);
          } else {
            return true;
          }
        }
        return false;
      }).map((element) {
        return element as ModuleState<T>;
      }).toList();
    } else {
      return moduleStateTree.exteriorModules.where((ModuleState state) {
        if (state.templateType == T) {
          if (testState != null) {
            return testState(state);
          } else {
            return true;
          }
        }
        return false;
      }).map((element) {
        return element as ModuleState<T>;
      }).toList();
    }
  }
}

class ModuleStateTree {
  BuiltList<ModuleState> interiorModules;
  BuiltList<ModuleState> exteriorModules;

  ModuleStateTree() {
    interiorModules = new BuiltList<ModuleState>();
    exteriorModules = new BuiltList<ModuleState>();
  }

  @override
  int get hashCode => interiorModules.hashCode ^ exteriorModules.hashCode;

  @override
  operator ==(Object other) =>
      identical(this, other) ||
      other is ModuleStateTree &&
          other.interiorModules == interiorModules &&
          other.exteriorModules == exteriorModules;

  void addModuleState(ModuleState moduleState) {
    if (moduleState.template.moduleLocation == ModuleLocation.INTERIOR) {
      var builder = interiorModules.toBuilder()..add(moduleState);
      interiorModules = builder.build();
    } else {
      var builder = exteriorModules.toBuilder()..add(moduleState);
      exteriorModules = builder.build();
    }
  }

  factory ModuleStateTree.withStates(List<ModuleState> states) {
    ModuleStateTree tree = ModuleStateTree();
    for (ModuleState state in states) {
      tree.addModuleState(state);
    }
    return tree;
  }
}
