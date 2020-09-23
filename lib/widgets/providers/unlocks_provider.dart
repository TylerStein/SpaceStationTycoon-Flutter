import 'package:flutter/cupertino.dart';
import 'package:space_station_tycoon/models/modules/module.dart';
import 'package:space_station_tycoon/models/modules/module_factory.dart';
import 'package:space_station_tycoon/models/modules/templates.dart';
import 'package:space_station_tycoon/widgets/providers/notifier.dart';

class UnlocksProvider extends GameStateNotifier {
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
        ModuleFactory.getModuleTemplate<StoreModuleTemplate>(),
      ],
      submoduleUnlocks: [
        ModuleFactory.getSubmoduleTemplate<FuelingSubmoduleTemplate>(),
        ModuleFactory.getSubmoduleTemplate<RepairSubmoduleTemplate>(),
      ]
    );
}