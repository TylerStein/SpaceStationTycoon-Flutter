
import 'package:space_station_tycoon/models/log_model.dart';
import 'package:space_station_tycoon/models/modules/module.dart';
import 'package:space_station_tycoon/redux/actions/generic_actions.dart';
import 'package:space_station_tycoon/redux/state/visitor_state.dart';

/// Runs automation logic for a module
class RunModuleLogicAction {
  final ModuleState module;
  RunModuleLogicAction(this.module);
}

/// Runs automation logic for a visitor
class RunVisitorLogicAction {
  final Visitor visitor;
  RunVisitorLogicAction(this.visitor);
}

/// Generates a new visitor to potentially land
class GenerateVisitorAction {}
class AddVisitorAction implements LoggableAction {
  Visitor visitor;
  LogEvent get logEvent => LogEvent.logArrival(visitor);
  AddVisitorAction(this.visitor);
}

class RemoveVisitorAction implements LoggableAction {
  Visitor visitor;
  LogEvent get logEvent => LogEvent.logDeparture(visitor);
  RemoveVisitorAction(this.visitor);
}