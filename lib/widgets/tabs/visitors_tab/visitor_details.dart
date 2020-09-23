import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_station_tycoon/models/provider_models/visitor_model.dart';
import 'package:space_station_tycoon/widgets/generic/module_detail.dart';
import 'package:space_station_tycoon/widgets/providers/resources_provider.dart';

class VisitorDetails extends StatelessWidget {
  final Visitor visitor;

  VisitorDetails({
    Key key,
    @required this.visitor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ModuleDetail(
      child: Consumer<ResourcesProvider>(
      builder: (BuildContext context, ResourcesProvider provider, Widget child) =>
        Column(
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
        )
      ),
    );
  }
}