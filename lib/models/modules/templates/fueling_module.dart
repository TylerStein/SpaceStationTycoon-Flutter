import 'package:space_station_tycoon/game_loop.dart';
import 'package:space_station_tycoon/models/modules/module.dart';
import 'package:space_station_tycoon/models/modules/templates/dock_module.dart';

class FuelingSubmoduleTemplate extends SubmoduleTemplate<DockModuleTemplate> {
  const FuelingSubmoduleTemplate() : super();

  @override
  String get shortName => 'FUELING';

  @override
  int get baseCreditCost => 500;

  @override
  bool parentModuleMeetsRequirements(DockModuleTemplate parent) {
    // TODO: implement parentModuleMeetsRequirements
    throw UnimplementedError();
  }

  @override
  FuelingSubmoduleState createDefaultState() => FuelingSubmoduleState(this);
}

class FuelingSubmoduleState extends SubmoduleState<FuelingSubmoduleTemplate> {
  FuelingSubmoduleState(FuelingSubmoduleTemplate template) : super(template);
  
  void updateSubmodule(GameLoopLogic game) {
    
  }
}