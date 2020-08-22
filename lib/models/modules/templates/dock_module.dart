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

class DockModuleState extends ModuleState<DockModuleTemplate> {
  VisitorID visitorID;
  List<SubmoduleState> _submodules;

  bool get isOccupied => visitorID != null;
  bool get isNotOccupied => !isOccupied;

  DockModuleState(DockModuleTemplate template): super(template) {
    _submodules = new List<SubmoduleState>();
  }

  @override
  void addSubmodule<K extends SubmoduleTemplate<DockModuleTemplate>>(SubmoduleState<K> submodule) {
    _submodules.add(submodule);
  }

  @override
  List<SubmoduleState<K>> getSubmodules<K extends SubmoduleTemplate<DockModuleTemplate>>() {
    return _submodules.toList();
  }

  void updateModule(GameLoopLogic game) {
    _submodules.forEach((element) {
      element.updateSubmodule(game);
    });
  }

  bool removeVisitor(VisitorID visitorID) {
    if (this.visitorID == visitorID) {
      this.visitorID = null;
      return true;
    } else {
      return false;
    }
  }
}