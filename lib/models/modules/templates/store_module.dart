import 'package:redux/redux.dart';
import 'package:space_station_tycoon/models/id.dart';
import 'package:space_station_tycoon/models/modules/module.dart';
import 'package:space_station_tycoon/redux/actions/state_actions.dart';
import 'package:space_station_tycoon/redux/state/state.dart';

class StoreModuleTemplate extends ModuleTemplate {
  const StoreModuleTemplate() : super(ModuleLocation.INTERIOR);

  @override
  String get shortName => 'STORE';


  @override
  int get baseCreditCost => 2500;

  @override
  int get baseModuleSlots => 0;

  @override
  bool stationMeetsRequirements(Store<GameState> store) {
    return (store.state.moduleState.interiorModules.length + 1) <= store.state.moduleState.maxInteriorModules
      && store.state.resourceState.credits.value >= baseCreditCost;
  }
  
  @override
  StoreModuleState createDefaultState() => StoreModuleState(this);
}

class StoreModuleState extends ModuleState<StoreModuleTemplate> {
  ID visitorID;
  List<SubmoduleState<SubmoduleTemplate<StoreModuleTemplate>, StoreModuleTemplate>> _submodules;
  // Map<ID, Visitor> _visitors;

  bool get isOccupied => visitorID != null;

  // @override
  // List<ID> get visitorIDs => _visitors.keys.toList();

  // @override
  // List<Visitor> get visitors => _visitors.values;

  // @override
  // bool get hasVisitors => _visitors.isNotEmpty;

  StoreModuleState(StoreModuleTemplate template): super(template) {
    _submodules = List<SubmoduleState<SubmoduleTemplate<StoreModuleTemplate>, StoreModuleTemplate>>.empty(growable: true);
    // _visitors = new Map<ID, Visitor>();
  }

  @override
  int get submoduleCount => _submodules.length;

  @override
  void addSubmodule<T extends SubmoduleTemplate<StoreModuleTemplate>>(SubmoduleState<T, StoreModuleTemplate> submodule) {
    _submodules.add(submodule);
  }

  @override
  List<SubmoduleState<K, StoreModuleTemplate>> getSubmodules<K extends SubmoduleTemplate<StoreModuleTemplate>>() {
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
  // void removeVisitor(ID visitorID) {
  //   _visitors.remove(visitorID);
  // }

  // @override
  // void addVisitor(Visitor visitor) {
  //   _visitors[visitor.id] = visitor;
  // }
}