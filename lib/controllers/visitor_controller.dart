import 'package:redux/redux.dart';
import 'package:space_station_tycoon/controllers/module_controller.dart';
import 'package:space_station_tycoon/models/id.dart';
import 'package:space_station_tycoon/models/needs/visitor_needs.dart';
import 'package:space_station_tycoon/models/visitors/visitor.dart';
import 'package:space_station_tycoon/redux/actions/game_actions.dart';
import 'package:space_station_tycoon/redux/state/states.dart';

/// For operating on Visitor instances
class VisitorController {
  VisitorController();

  void updateVisitor(Visitor visitor, ModuleController moduleController, Store<GameState> store) {
    Set<ID> visitedModules = store.state.moduleVisitorBindingState.getVisitorModules(visitor.id);
    if (visitor.activeNeed != null) {
      if (visitor.satisfactionPercent <= 0) {
        if (visitedModules.length > 0) {
          store.dispatch(RemoveVisitorModuleBindingAction.forVisitor(visitor.id));
        }
      } else if (visitor.activeNeed.isFufilled) {
        if (visitedModules.length > 0) {
          store.dispatch(RemoveVisitorModuleBindingAction.forVisitor(visitor.id));
        }

        visitor.openNeeds.removeWhere((element) => element == visitor.activeNeed);
        visitor.removeActiveNeed();
      } else {
        visitor.activeNeed.updateNeed(store);
      }
    } else if (visitor.openNeeds.isNotEmpty) {
      VisitorNeed nextNeed = visitor.getNextNeed(store);
      if (nextNeed != null) {
        bool occupiedModule = nextNeed.tryOccupyModule(store);
        if (occupiedModule) {
          visitor.activeNeed = nextNeed;
        }
      } else {
        visitor.updateSatisfaction(-1);
        if (visitor.satisfactionPercent <= 0) {
          store.dispatch(RemoveVisitorModuleBindingAction.forVisitor(visitor.id));
          store.dispatch(RemoveVisitorAction(visitor));
        }
      }
    } else {
      store.dispatch(RemoveVisitorModuleBindingAction.forVisitor(visitor.id));
      store.dispatch(RemoveVisitorAction(visitor));
    }
  }
}