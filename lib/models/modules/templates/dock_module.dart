import 'package:redux/redux.dart';
import 'package:space_station_tycoon/models/modules/module.dart';
import 'package:space_station_tycoon/redux/actions/state_actions.dart';
import 'package:space_station_tycoon/redux/state/state.dart';

class DockModuleTemplate extends ModuleTemplate {
  const DockModuleTemplate() : super(ModuleLocation.EXTERIOR);

  @override
  String get shortName => 'DOCK';


  @override
  int get baseCreditCost => 5000;

  @override
  int get baseModuleSlots => 3;

  @override
  bool stationMeetsRequirements(Store<GameState> store) {
    return (store.state.moduleState.exteriorModules.length + 1) <= store.state.moduleState.maxInteriorModules
      && store.state.resourceState.credits.value >= baseCreditCost;
  }
  
  @override
  DockModuleState createDefaultState() => DockModuleState(this);
}

class DockModuleState extends ModuleState<DockModuleTemplate> {
  List<SubmoduleState<SubmoduleTemplate<DockModuleTemplate>, DockModuleTemplate>> _submodules;

  // bool get isOccupied => visitorID != null;

  DockModuleState(DockModuleTemplate template): super(template) {
    _submodules = new List<SubmoduleState<SubmoduleTemplate<DockModuleTemplate>, DockModuleTemplate>>();
  }

  @override
  int get submoduleCount => _submodules.length;

  @override
  void addSubmodule<T extends SubmoduleTemplate<DockModuleTemplate>>(SubmoduleState<T, DockModuleTemplate> submodule) {
    _submodules.add(submodule);
  }

  @override
  List<SubmoduleState<K, DockModuleTemplate>> getSubmodules<K extends SubmoduleTemplate<DockModuleTemplate>>() {
    return this._submodules;
  }

  void updateModule(Store<GameState> store) {
    // Apply module running costs
    store.dispatch(SetResourceStateAction(
      store.state.resourceState.withAddFuel(-1),
    ));

    _submodules.forEach((element) {
      element.updateSubmodule(store, this);
    });
  }

  // @override
  // void removeVisitor() {
  //   visitorID = null;
  // }

  // @override
  // void setVisitor(Visitor visitor) {
  //   visitorID = visitor.id;
  // }
}