import 'package:flutter/widgets.dart';
import 'package:space_station_tycoon/models/modules/module.dart';
import 'package:space_station_tycoon/models/modules/module_factory.dart';
import 'package:space_station_tycoon/models/provider_models/modules_model.dart';
import 'package:space_station_tycoon/widgets/providers/notifier.dart';

class ModulesProvider extends GameStateNotifier {
  ModulesModel data;

  ModulesProvider({
    this.data,
  });

  int get moduleCount => data.moduleCount;
  List<ModuleState> get interiorModules => data.interiorModuleStates;
  List<ModuleState> get exteriorModules => data.exteriorModuleStates;

  int get maxInteriorModules => data.maxInteriorModules;
  int get maxExteriorModules => data.maxExteriormodules;

  List<ModuleState<T>> getModulesOfType<T extends ModuleTemplate>({ bool Function(ModuleState<T> state) testState }) {
    ModuleLocation location = ModuleFactory.getModuleTemplate<T>().moduleLocation;
    if (location == ModuleLocation.INTERIOR) {
      return interiorModules.where((ModuleState state) {
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
      }).toList() as List<ModuleState<T>>;
    } else {
      return exteriorModules.where((ModuleState state) {
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
      }).toList() as List<ModuleState<T>>;
    }
  }

  void addModule(ModuleTemplate moduleTemplate, [bool notify = true]) {
    data.addModuleState(moduleTemplate.createDefaultState());
    notifyOrMarkDirty(notify);
  }

  factory ModulesProvider.createDefault(BuildContext context) =>
    ModulesProvider(data: ModulesModel.createDefault());
}