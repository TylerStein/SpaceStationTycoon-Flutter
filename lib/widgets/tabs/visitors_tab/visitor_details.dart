import 'package:flutter/material.dart';
import 'package:space_station_tycoon/redux/state/visitor_state.dart';

class VisitorDetails extends StatelessWidget {
  final Visitor visitor;

  VisitorDetails({
    Key key,
    @required this.visitor,
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
        Text(visitor.occupyingModule?.toString() ?? 'No occupied module'),
        Text('Active Need:'),
        Text(visitor.activeNeed?.toString() ?? 'No active need'),
      ],
    );
  }
}