import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:space_station_tycoon/widgets/tabs/economy_tab/resource_details.dart';

class ResourceCard extends StatelessWidget {
  final String label;
  final num currentValue;
  final num lastValueChange;
  final Function() onTap;
  
  ResourceCard({
    Key key,
    @required this.label,
    @required this.currentValue,
    @required this.lastValueChange,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isPositive = lastValueChange >= 0;
    Color valueColor = Theme.of(context).colorScheme.onSurface;
    if (lastValueChange > 0) {
      valueColor = Theme.of(context).colorScheme.secondary;
    } else if (lastValueChange < 0) {
      valueColor = Theme.of(context).colorScheme.error;
    }

    return Card(
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
              Text(label),
              Spacer(),
              Text(currentValue.toString(), textAlign: TextAlign.right),
              Text(' (${(isPositive ? '+' : '')}${lastValueChange.toString()})', style: Theme.of(context).textTheme.bodyText1.copyWith(color: valueColor))
            ],
          ),
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    onTap();
    Scaffold.of(context).showBottomSheet(
      (context) => ResourceDetails(
        label: label,
      )
    );
  }
}