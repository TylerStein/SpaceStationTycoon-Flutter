import 'package:space_station_tycoon/game_loop.dart';
import 'package:space_station_tycoon/models/modules/module.dart';
import 'package:space_station_tycoon/models/provider_models/visitor_model.dart';

class StorageModuleTemplate extends ModuleTemplate {
  const StorageModuleTemplate() : super(ModuleLocation.INTERIOR);

  @override
  String get shortName => 'STORAGE';

  @override
  int get baseCreditCost => 500;

  @override
  bool stationMeetsRequirements(dynamic station) {
    // TODO: implement parentModuleMeetsRequirements
    throw UnimplementedError();
  }

  @override
  StorageModuleState createDefaultState() => StorageModuleState(this);
}

class StorageModuleState extends ModuleState<StorageModuleTemplate> {
  int dockedShipId;
  List<SubmoduleState> _submodules;

  StorageModuleState(StorageModuleTemplate template) : super(template) {
    _submodules = new List<SubmoduleState>();
  }

  @override
  void addSubmodule<K extends SubmoduleTemplate<StorageModuleTemplate>>(SubmoduleState<K> submodule) {
    _submodules.add(submodule);
  }

  @override
  List<SubmoduleState<K>> getSubmodules<K extends SubmoduleTemplate<StorageModuleTemplate>>() {
    return _submodules.toList();
  }

  void updateModule(GameLoopLogic game) {
    _submodules.forEach((element) {
      element.updateSubmodule(game);
    });
  }

  bool removeVisitor(VisitorID visitorId) => false;
}