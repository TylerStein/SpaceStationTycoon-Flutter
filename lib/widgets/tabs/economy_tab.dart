import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_station_tycoon/widgets/providers/resources_provider.dart';

class EconomyTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ResourcesProvider>(
      builder: (BuildContext context, ResourcesProvider provider, Widget child) => 
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCard(context, 'Credits', provider.credits, provider.creditsDifference),
            _buildCard(context, 'Fuel', provider.fuel, provider.fuelDifference),
          ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, String label, num currentValue, num lastValueChange) {
    bool isPositive = lastValueChange >= 0;
    Color valueColor = Theme.of(context).colorScheme.onSurface;
    if (lastValueChange > 0) {
      valueColor = Theme.of(context).colorScheme.secondary;
    } else if (lastValueChange < 0) {
      valueColor = Theme.of(context).colorScheme.error;
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
    );
  }
}