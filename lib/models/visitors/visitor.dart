import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import 'package:space_station_tycoon/models/id.dart';
import 'package:space_station_tycoon/models/needs/visitor_needs.dart';
import 'package:space_station_tycoon/redux/state/states.dart';

class Visitor {
  ID id;
  String name;

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
    this.satisfactionPercent,
  }) {
    if (openNeeds == null) openNeeds = List<VisitorNeed>.empty(growable: true);
    if (closedNeeds == null) closedNeeds = List<VisitorNeed>.empty(growable: true);
    if (satisfactionPercent == null) satisfactionPercent = 100;
  }

  void updateSatisfaction(int change) {
    satisfactionPercent += change;
    if (satisfactionPercent < 0) satisfactionPercent = 0;
    else if (satisfactionPercent > 100) satisfactionPercent = 100;
  }

  void removeActiveNeed() {
    openNeeds.removeWhere((element) => element == activeNeed);
    activeNeed = null;
  }
  
  VisitorNeed getNextNeed(Store<GameState> store) {
    return openNeeds.firstWhere((element) => element.canBeFufilled(store), orElse: () => null);
  }
}