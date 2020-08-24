import 'package:space_station_tycoon/game_loop.dart';
import 'package:space_station_tycoon/models/modules/module.dart';
import 'package:space_station_tycoon/models/provider_models/visitor_model.dart';

class DockModuleTemplate extends ModuleTemplate {
  const DockModuleTemplate() : super(ModuleLocation.EXTERIOR);

  @override
  String get shortName => 'DOCK';


  @override
  int get baseCreditCost => 5000;

  @override
  bool stationMeetsRequirements(dynamic station) {
    // TODO: implement parentModuleMeetsRequirements
    throw UnimplementedError();
  }
  
  @override
  DockModuleState createDefaultState() => DockModuleState(this);
}

class DockModuleState extends ModuleState<DockModuleTemplate> implements SingleVisitorModuleState {
  VisitorID visitorID;
  List<SubmoduleState> _submodules;

  bool get isOccupied => visitorID != null;

  DockModuleState(DockModuleTemplate template): super(template) {
    _submodules = new List<SubmoduleState>();
  }

  @override
  void addSubmodule<T extends SubmoduleTemplate<DockModuleTemplate>>(SubmoduleState<T, DockModuleTemplate> submodule) {
    _submodules.add(submodule);
  }

  @override
  List<SubmoduleState<T, DockModuleTemplate>> getSubmodules<T extends SubmoduleTemplate<DockModuleTemplate>>() {
    return _submodules.toList();
  }

  void updateModule(GameLoopLogic game) {
    // Apply module running costs
    game.resourcesProvider.addFuel(-1);

    _submodules.forEach((element) {
      element.updateSubmodule(game, this);
    });
  }

  @override
  void removeVisitor() {
    visitorID = null;
  }

  @override
  void setVisitor(Visitor visitor) {
    visitorID = visitor.id;
  }
}