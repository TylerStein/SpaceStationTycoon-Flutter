import 'package:space_station_tycoon/game_loop.dart';
import 'package:space_station_tycoon/models/modules/module.dart';
import 'package:space_station_tycoon/models/provider_models/visitor_model.dart';

class StoreModuleTemplate extends ModuleTemplate {
  const StoreModuleTemplate() : super(ModuleLocation.INTERIOR);

  @override
  String get shortName => 'STORE';


  @override
  int get baseCreditCost => 2500;

  @override
  int get baseModuleSlots => 0;

  @override
  bool stationMeetsRequirements(GameLoopLogic game) {
    return (game.modulesProvider.interiorModules.length + 1) <= game.modulesProvider.maxInteriorModules
      && game.resourcesProvider.credits >= baseCreditCost;
  }
  
  @override
  StoreModuleState createDefaultState() => StoreModuleState(this);
}

class StoreModuleState extends ModuleState<StoreModuleTemplate> implements MultiVisitorModuleState {
  VisitorID visitorID;
  List<SubmoduleState<SubmoduleTemplate<StoreModuleTemplate>, StoreModuleTemplate>> _submodules;
  Map<VisitorID, Visitor> _visitors;

  bool get isOccupied => visitorID != null;

  @override
  List<VisitorID> get visitorIDs => _visitors.keys.toList();

  @override
  List<Visitor> get visitors => _visitors.values;

  @override
  bool get hasVisitors => _visitors.isNotEmpty;

  StoreModuleState(StoreModuleTemplate template): super(template) {
    _submodules = new List<SubmoduleState<SubmoduleTemplate<StoreModuleTemplate>, StoreModuleTemplate>>();
    _visitors = new Map<VisitorID, Visitor>();
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

  void updateModule(GameLoopLogic game) {
    // Apply module running costs
    game.resourcesProvider.addFuel(-1);

    _submodules.forEach((element) {
      element.updateSubmodule(game, this);
    });
  }

  @override
  void removeVisitor(VisitorID visitorID) {
    _visitors.remove(visitorID);
  }

  @override
  void addVisitor(Visitor visitor) {
    _visitors[visitor.id] = visitor;
  }
}