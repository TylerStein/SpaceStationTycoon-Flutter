import 'package:flutter/cupertino.dart';
import 'package:space_station_tycoon/game_loop.dart';
import 'package:space_station_tycoon/models/modules/module.dart';
import 'package:space_station_tycoon/models/needs/visitor_needs.dart';
import 'package:space_station_tycoon/widgets/providers/visitors_provider.dart';

class Visitor {
  VisitorID id;
  SingleVisitorModuleState occupyingModule;

  VisitorNeed activeNeed;
  List<VisitorNeed> openNeeds;
  List<VisitorNeed> closedNeeds;

  Visitor({
    @required this.id,
    this.openNeeds = const [],
    this.closedNeeds = const [],
    this.activeNeed,
    this.occupyingModule,
  });

  void updateVisitor(GameLoopLogic game) {
    if (activeNeed != null) {
      // Update or remove the active need
      if (activeNeed.isFufilled) {
        if (occupyingModule != null) {
          occupyingModule.removeVisitor();
        }
        openNeeds.removeWhere((element) => element == activeNeed);
        activeNeed = null;
      } else {
        activeNeed.updateNeed(game);
      }
    } else if (openNeeds.isNotEmpty) {
      // Find a new need
      VisitorNeed nextNeed = openNeeds.firstWhere((element) => element.canBeFufilled(game));
      if (activeNeed != null) {
        bool occupiedModule = nextNeed.tryOccupyModule(game);
        if (occupiedModule) {
          activeNeed = nextNeed;
        }
      }
    } else {
      // Leave the station
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

  factory VisitorID.unique() {
    return new VisitorID(VisitorID._visitorIndex++);
  }
}

class VisitorModel {
  Map<VisitorID, Visitor> _visitors;

  VisitorModel();

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