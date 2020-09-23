import 'package:flutter/cupertino.dart';
import 'package:space_station_tycoon/game_loop.dart';
import 'package:space_station_tycoon/models/log_model.dart';
import 'package:space_station_tycoon/models/modules/module.dart';
import 'package:space_station_tycoon/models/needs/visitor_needs.dart';

class Visitor {
  VisitorID id;
  String name;
  SingleVisitorModuleState occupyingModule;

  int satisfactionPercent;

  VisitorNeed activeNeed;
  List<VisitorNeed> openNeeds;
  List<VisitorNeed> closedNeeds;

  String get displayName => name ?? id;

  Visitor({
    @required this.id,
    @required this.name,
    this.openNeeds,
    this.closedNeeds,
    this.activeNeed,
    this.occupyingModule,
    this.satisfactionPercent,
  }) {
    if (openNeeds == null) openNeeds = List<VisitorNeed>();
    if (closedNeeds == null) closedNeeds = List<VisitorNeed>();
    if (satisfactionPercent == null) satisfactionPercent = 100;
  }

  void updateSatisfaction(int change) {
    satisfactionPercent += change;
    if (satisfactionPercent < 0) satisfactionPercent = 0;
    else if (satisfactionPercent > 100) satisfactionPercent = 100;
  }

  void updateVisitor(GameLoopLogic game) {
    if (activeNeed != null) {
      // Update or remove the active need
      if (satisfactionPercent <= 0) {
        if (occupyingModule != null) {
          occupyingModule.removeVisitor();
        }
        game.metadataProvider.addLog(LogEvent.logDissatisfied(this, 'Leaving due to disappointment'));
        game.visitorsProvider.removeVisitor(id);
      }

      if (activeNeed.isFufilled) {
        if (occupyingModule != null) {
          occupyingModule.removeVisitor();
        }
        openNeeds.removeWhere((element) => element == activeNeed);
        game.metadataProvider.addLog(LogEvent.logSatisfied(this, 'Fufilled a need: ${activeNeed.runtimeType.toString()}'));
        activeNeed = null;
      } else {
        activeNeed.updateNeed(game);
      }
    } else if (openNeeds.isNotEmpty) {
      // Find a new need
      VisitorNeed nextNeed = openNeeds.firstWhere((element) {
        bool canBeFufilled = element.canBeFufilled(game);
        return canBeFufilled;
      }, orElse: () => null);
      if (nextNeed != null) {
        bool occupiedModule = nextNeed.tryOccupyModule(game);
        if (occupiedModule) {
          game.metadataProvider.addLog(LogEvent.logInfo('Visitor $displayName has occupied a module: ${occupyingModule.runtimeType.toString()}'));
          activeNeed = nextNeed;
        }
      }
    } else {
      // Leave the station
      game.metadataProvider.addLog(LogEvent.logDeparture(this));
      game.visitorsProvider.removeVisitor(id);
    }
  }
}

class VisitorID {
  static int _visitorIndex = 0;

  int id;
  VisitorID(this.id);

  @override
  int get hashCode => id.hashCode;

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is VisitorID &&
    other.id == this.id;

  @override
  String toString() => id.toString();

  factory VisitorID.unique() {
    return new VisitorID(VisitorID._visitorIndex++);
  }
}

class VisitorModel {
  Map<VisitorID, Visitor> _visitors;

  VisitorModel() {
    _visitors = new Map<VisitorID, Visitor>();
  }

  void addVisitor(Visitor visitor) {
    _visitors[visitor.id] = visitor;
  }

  Visitor getVisitor(VisitorID id) {
    return _visitors[id];
  }

  bool removeVisitor(VisitorID id) {
    return _visitors.remove(id) != null;
  }

  List<Visitor> getAllVisitors() {
    return _visitors.values.toList();
  }

  factory VisitorModel.createDefault(BuildContext context) =>
    VisitorModel();
}