import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:space_station_tycoon/models/modules/module.dart';
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

  bool canBuildModule<T extends ModuleTemplate>() {
    return false;
  }

  bool canBuildSubmodule<T extends ModuleTemplate, K extends SubmoduleTemplate<T>>(ModuleState<T> target) {
    return false;
  }
}