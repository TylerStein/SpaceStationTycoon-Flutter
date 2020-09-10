import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:space_station_tycoon/game_loop.dart';
import 'package:space_station_tycoon/models/modules/module.dart';
import 'package:space_station_tycoon/models/modules/module_factory.dart';
import 'package:space_station_tycoon/widgets/providers/modules_provider.dart';
import 'package:space_station_tycoon/widgets/providers/resources_provider.dart';
import 'package:space_station_tycoon/widgets/providers/unlocks_provider.dart';

class BuildInteractionProvider extends ChangeNotifier {
  ResourcesProvider resourcesProvider;
  UnlocksProvider unlocksProvider;
  ModulesProvider modulesProvider;

  BuildInteractionProvider({
    @required this.resourcesProvider,
    @required this.unlocksProvider,
    @required this.modulesProvider,
  });

  bool canBuildModule<T extends ModuleTemplate>(GameLoopLogic game) {
    final ModuleTemplate template = ModuleFactory.getModuleTemplate<T>();
    return template.stationMeetsRequirements(game);
  }

  bool canBuildSubmodule<T extends ModuleTemplate, K extends SubmoduleTemplate<T>>(GameLoopLogic game, ModuleState<T> target) {
    final SubmoduleTemplate template = ModuleFactory.getSubmoduleTemplate<K>();
    return template.parentModuleMeetsRequirements(game, target);
  }
}