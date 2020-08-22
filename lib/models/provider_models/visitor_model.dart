import 'package:flutter/cupertino.dart';
import 'package:space_station_tycoon/game_loop.dart';
import 'package:space_station_tycoon/models/modules/module.dart';

class Visitor {
  VisitorID id;
  ModuleState occupyingModule;

  void updateVisitor(GameLoopLogic game) {
    
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

  List<Visitor> getAllVisitors() {
    return _visitors.values.toList();
  }

  factory VisitorModel.createDefault(BuildContext context) =>
    VisitorModel();
}