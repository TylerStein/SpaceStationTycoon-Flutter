import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:space_station_tycoon/models/provider_models/visitor_model.dart';
import 'package:space_station_tycoon/widgets/providers/metadata_provider.dart';
import 'package:space_station_tycoon/widgets/providers/modules_provider.dart';
import 'package:space_station_tycoon/widgets/providers/resources_provider.dart';
import 'package:space_station_tycoon/widgets/providers/tick_provider.dart';
import 'package:space_station_tycoon/widgets/providers/visitors_provider.dart';

import 'models/needs/visitor_needs.dart';

/// Works with the game providers to update them based on the automatic passing of time
class GameLoopLogic extends StatefulWidget {
  final Widget child;
  final ModulesProvider modulesProvider;
  final MetadataProvider metadataProvider;
  final ResourcesProvider resourcesProvider;
  final TickProvider tickProvider;
  final VisitorsProvider visitorsProvider;

  GameLoopLogic({
    Key key,
    @required this.child,
    @required this.modulesProvider,
    @required this.metadataProvider,
    @required this.resourcesProvider,
    @required this.tickProvider,
    @required this.visitorsProvider,
  }) : super(key: key);

  @override
  _GameLoopLogicState createState() => _GameLoopLogicState();
}

class _GameLoopLogicState extends State<GameLoopLogic> {
  StreamSubscription<int> _subscription;

  @override
  void initState() {
    _subscription = widget.tickProvider.stream.listen((event) => onTick(event));
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void onTick(int frame) {
    setState(() {
      updateModules(frame);
      updateVisitors(frame);
      updateWorld(frame);
      widget.metadataProvider.setDay(frame, false);

      notifyAllDirty();
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;

  void notifyAllDirty() {
    widget.modulesProvider.notifyIfDirty();
    widget.metadataProvider.notifyIfDirty();
    widget.resourcesProvider.notifyIfDirty();
    widget.visitorsProvider.notifyIfDirty();
  }

  void updateModules(int frame) {
    widget.modulesProvider.interiorModules.forEach((element) {
      element.updateModule(widget);
    });

    widget.modulesProvider.exteriorModules.forEach((element) {
      element.updateModule(widget);
    });
  }

  void updateVisitors(int frame) {  
    widget.visitorsProvider.allVisitors.forEach((element) {
      element.updateVisitor(widget);
    });
  }

  void updateWorld(int frame) {
    if (widget.visitorsProvider.allVisitors.isEmpty) {
      Visitor visitor = Visitor(id: VisitorID.unique());
      visitor.openNeeds.add(FuelingNeed(
        visitor: visitor,
        fuelTier: 1,
        fuelCount: 10,
      ));

      widget.visitorsProvider.addVisitor(visitor);
    }
  }
}