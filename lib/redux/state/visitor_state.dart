import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:space_station_tycoon/models/modules/module.dart';
import 'package:space_station_tycoon/models/needs/visitor_needs.dart';

@immutable
class VisitorState {
  final BuiltMap<VisitorID, Visitor> visitors;

  VisitorState({
    @required this.visitors,
  });

  VisitorState copyWith({
    BuiltMap<VisitorID, Visitor> visitors,
  }) => VisitorState(
    visitors: visitors ?? this.visitors,
  );

  factory VisitorState.createDefault() =>
    VisitorState(
      visitors: BuiltMap<VisitorID, Visitor>(),
    );
}

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

  // void updateVisitor(GameLoopLogic game) {
  //   if (activeNeed != null) {
  //     // Update or remove the active need
  //     if (satisfactionPercent <= 0) {
  //       if (occupyingModule != null) {
  //         occupyingModule.removeVisitor();
  //       }
  //       game.metadataProvider.addLog(LogEvent.logDissatisfied(this, 'Leaving due to disappointment'));
  //       game.visitorsProvider.removeVisitor(id);
  //     }

  //     if (activeNeed.isFufilled) {
  //       if (occupyingModule != null) {
  //         occupyingModule.removeVisitor();
  //       }
  //       openNeeds.removeWhere((element) => element == activeNeed);
  //       game.metadataProvider.addLog(LogEvent.logSatisfied(this, 'Fufilled a need: ${activeNeed.runtimeType.toString()}'));
  //       activeNeed = null;
  //     } else {
  //       activeNeed.updateNeed(game);
  //     }
  //   } else if (openNeeds.isNotEmpty) {
  //     // Find a new need
  //     VisitorNeed nextNeed = openNeeds.firstWhere((element) {
  //       bool canBeFufilled = element.canBeFufilled(game);
  //       return canBeFufilled;
  //     }, orElse: () => null);
  //     if (nextNeed != null) {
  //       bool occupiedModule = nextNeed.tryOccupyModule(game);
  //       if (occupiedModule) {
  //         game.metadataProvider.addLog(LogEvent.logInfo('Visitor $displayName has occupied a module: ${occupyingModule.runtimeType.toString()}'));
  //         activeNeed = nextNeed;
  //       }
  //     }
  //   } else {
  //     // Leave the station
  //     game.metadataProvider.addLog(LogEvent.logDeparture(this));
  //     game.visitorsProvider.removeVisitor(id);
  //   }
  // }
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