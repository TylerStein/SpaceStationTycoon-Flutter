import 'package:flutter/foundation.dart';
import 'package:space_station_tycoon/models/modules/module_factory.dart';
import 'package:space_station_tycoon/models/modules/module.dart';
import 'package:space_station_tycoon/models/modules/templates/dock_module.dart';
import 'package:space_station_tycoon/models/modules/templates/fueling_module.dart';
import 'package:space_station_tycoon/models/modules/templates/storage_module.dart';

class ModuleStateTree {
  List<ModuleState> interiorModules;
  List<ModuleState> exteriorModules;

  ModuleStateTree() {
    interiorModules = new List<ModuleState>();
    exteriorModules = new List<ModuleState>();
  }

  void addModuleState(ModuleState moduleState) {
    if (moduleState.template.moduleLocation == ModuleLocation.INTERIOR) {
      interiorModules.add(moduleState);
    } else {
      exteriorModules.add(moduleState);
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

class ModulesModel {
  int maxInteriorModules;
  int maxExteriormodules;

  ModuleStateTree moduleStateTree;

  ModulesModel({
    @required this.maxInteriorModules,
    @required this.maxExteriormodules,
    @required this.moduleStateTree,
  });

  List<ModuleState> get interiorModuleStates => moduleStateTree.interiorModules;
  List<ModuleState> get exteriorModuleStates => moduleStateTree.exteriorModules;
  int get moduleCount => moduleStateTree.interiorModules.length + moduleStateTree.exteriorModules.length;

  void addModuleState(ModuleState state) {
    moduleStateTree.addModuleState(state);
  }

  void addModuleStates(List<ModuleState> states) {
    for (ModuleState state in states) {
      moduleStateTree.addModuleState(state);
    }
  }

  // @override
  // int get hashCode => moduleStateTree.hashCode;

  // @override
  // operator ==(Object other) =>
  //   identical(this, other) ||
  //   other is ModulesModel &&
  //   other.moduleStateTree == moduleStateTree;

  factory ModulesModel.createDefault() => ModulesModel(
    maxExteriormodules: 2,
    maxInteriorModules: 2,
    moduleStateTree: ModuleStateTree.withStates([
      ModuleFactory.createDefaultModuleTemplateState<DockModuleTemplate>(
        submoduleStates: [
          ModuleFactory.getSubmoduleTemplate<FuelingSubmoduleTemplate>().createDefaultState(),
        ],
      ),
      ModuleFactory.getModuleTemplate<StorageModuleTemplate>().createDefaultState()
    ]),
  );
}