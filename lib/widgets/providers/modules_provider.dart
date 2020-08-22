import 'package:flutter/widgets.dart';
import 'package:space_station_tycoon/models/modules/module.dart';
import 'package:space_station_tycoon/models/modules/module_factory.dart';
import 'package:space_station_tycoon/models/provider_models/modules_model.dart';

class ModulesProvider extends ChangeNotifier {
  ModulesModel data;

  ModulesProvider({
    this.data,
  });

  int get moduleCount => data.moduleCount;
  List<ModuleState> get interiorModules => data.interiorModuleStates;
  List<ModuleState> get exteriorModules => data.exteriorModuleStates;

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
      }).toList() as List<ModuleState<T>>;
    }
  }

  void addModule(ModuleTemplate moduleTemplate) {
    data.addModuleState(moduleTemplate.createDefaultState());
    notifyListeners();
  }

  factory ModulesProvider.createDefault(BuildContext context) =>
    ModulesProvider(data: ModulesModel.createDefault());
}