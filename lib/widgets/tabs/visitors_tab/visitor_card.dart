import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:space_station_tycoon/redux/state/visitor_state.dart';
import 'package:space_station_tycoon/widgets/tabs/visitors_tab/visitor_details.dart';

class VisitorCard extends StatelessWidget {
  final Visitor visitor;

  VisitorCard({
    Key key,
    @required this.visitor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size(double.infinity, 200),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => _onTap(context),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(visitor.id.toString()),
                Spacer(),
                Text('${visitor.satisfactionPercent.toString()}%')
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    Scaffold.of(context).showBottomSheet(
      (context) => VisitorDetails(
        visitor: visitor,
      )
    );
  }
}