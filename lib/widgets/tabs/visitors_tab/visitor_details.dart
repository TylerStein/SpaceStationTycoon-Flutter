import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:space_station_tycoon/models/modules/module.dart';
import 'package:space_station_tycoon/models/visitors/visitor.dart';

class VisitorDetails extends StatelessWidget {
  final Visitor visitor;
  final BuiltList<ModuleState> modules;

  VisitorDetails({
    Key key,
    @required this.visitor,
    @required this.modules,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: Theme.of(context).cardColor,
          child: Text(visitor.displayName.toString(), textAlign: TextAlign.left),
        ),
        Text('Occupying Module:'),
        Text(modules?.toString() ?? 'No occupied module'),
        Text('Active Need:'),
        Text(visitor.activeNeed?.toString() ?? 'No active need'),
      ],
    );
  }
}