import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_station_tycoon/widgets/providers/visitors_provider.dart';
import 'package:space_station_tycoon/widgets/tabs/visitors_tab/visitor_card.dart';

class VisitorsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<VisitorsProvider>(
      builder: (BuildContext context, VisitorsProvider visitorsProvider, Widget child) =>
        ListView.builder(
          itemCount: visitorsProvider.allVisitors.length,
          itemBuilder: (BuildContext context, int index) =>
            VisitorCard(visitor: visitorsProvider.allVisitors[index])
        ),
    );
  }
}