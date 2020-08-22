import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:space_station_tycoon/widgets/providers/metadata_provider.dart';
import 'package:space_station_tycoon/widgets/providers/modules_provider.dart';
import 'package:space_station_tycoon/widgets/providers/resources_provider.dart';
import 'package:space_station_tycoon/widgets/providers/tick_provider.dart';
import 'package:space_station_tycoon/widgets/providers/unlocks_provider.dart';
import 'package:space_station_tycoon/widgets/providers/visitors_provider.dart';

@immutable
class ProgressionHandler extends StatefulWidget {
  final TickProvider tickProvider;
  final MetadataProvider metadataProvider;
  final ResourcesProvider resourcesProvider;
  final UnlocksProvider unlocksProvider;
  final ModulesProvider modulesProvider;
  final VisitorsProvider visitorProvider;
  final Widget child;

  ProgressionHandler({
    Key key,
    @required this.child,
    @required this.tickProvider,
    @required this.metadataProvider,
    @required this.resourcesProvider,
    @required this.unlocksProvider,
    @required this.modulesProvider,
    @required this.visitorProvider,
  }) : super(key: key);

  @override
  _ProgressionHandlerState createState() => _ProgressionHandlerState();
}

class _ProgressionHandlerState extends State<ProgressionHandler> {
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

  @override
  Widget build(BuildContext context) => widget.child;

  void onTick(int frame) {
    setState(() {
      updateAI(frame);
      widget.metadataProvider.setDay(frame);
    });
  }

  void updateAI(int frame) {
    int fuelChange = 0;

    // add module operation costs to fuel change
    fuelChange -= widget.modulesProvider.moduleCount;

    // add incoming purchased fuel to fuel change
    fuelChange += 3;

    if (fuelChange != 0) widget.resourcesProvider.addFuel(fuelChange);
      
    widget.resourcesProvider.addCredits(1);
  }
}