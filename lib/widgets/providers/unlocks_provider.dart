import 'package:flutter/cupertino.dart';
import 'package:space_station_tycoon/models/modules/module.dart';
import 'package:space_station_tycoon/models/modules/module_factory.dart';
import 'package:space_station_tycoon/models/modules/templates/dock_module.dart';
import 'package:space_station_tycoon/models/modules/templates/fueling_module.dart';
import 'package:space_station_tycoon/models/modules/templates/storage_module.dart';

class UnlocksProvider extends ChangeNotifier {
  List<ModuleTemplate> templateUnlocks;
  List<SubmoduleTemplate> submoduleUnlocks;

  UnlocksProvider({
    this.templateUnlocks = const [],
    this.submoduleUnlocks = const [],
  });

  List<SubmoduleTemplate> getSubmoduleUnlocksForModule(Type moduleTemplateType) =>
    submoduleUnlocks.where((sub) => sub.parentType == moduleTemplateType).toList();

  factory UnlocksProvider.createDefault(BuildContext context) =>
    UnlocksProvider(
      templateUnlocks: [
        ModuleFactory.getModuleTemplate<DockModuleTemplate>(),
        ModuleFactory.getModuleTemplate<StorageModuleTemplate>(),
      ],
      submoduleUnlocks: [
        ModuleFactory.getSubmoduleTemplate<FuelingSubmoduleTemplate>(),
      ]
    );
}