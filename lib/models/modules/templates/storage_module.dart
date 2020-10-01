import 'package:redux/redux.dart';
import 'package:space_station_tycoon/models/modules/module.dart';
import 'package:space_station_tycoon/redux/state/state.dart';

class StorageModuleTemplate extends ModuleTemplate {
  const StorageModuleTemplate() : super(ModuleLocation.INTERIOR);

  @override
  String get shortName => 'STORAGE';

  @override
  int get baseCreditCost => 500;

  @override
  int get baseModuleSlots => 0;

  @override
  bool stationMeetsRequirements(Store<GameState> store) {
    return (store.state.moduleState.interiorModules.length + 1) <= store.state.moduleState.maxInteriorModules
      && store.state.resourceState.credits.value >= baseCreditCost;
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
  int get submoduleCount => _submodules.length;

  @override
  void addSubmodule<T extends SubmoduleTemplate<StorageModuleTemplate>>(SubmoduleState<T, StorageModuleTemplate> submodule) {
    _submodules.add(submodule);
  }

  @override
  List<SubmoduleState<T, StorageModuleTemplate>> getSubmodules<T extends SubmoduleTemplate<StorageModuleTemplate>>() {
    return _submodules.toList();
  }

  void updateModule(Store<GameState> store) {
    _submodules.forEach((element) {
      element.updateSubmodule(store, this);
    });
  }

  // bool removeVisitor(VisitorID visitorId) => false;
}