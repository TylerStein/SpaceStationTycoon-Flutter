import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_station_tycoon/widgets/providers/resources_provider.dart';
import 'package:space_station_tycoon/widgets/tabs/economy_tab/resource_card.dart';

class EconomyTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ResourcesProvider>(
      builder: (BuildContext context, ResourcesProvider provider, Widget child) => 
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ResourceCard(
              label: 'Credits',
              currentValue: provider.credits,
              lastValueChange: provider.creditsDifference,
              onTap: () {
                provider.addCredits(10);
              },
            ),
            ResourceCard(
              label: 'Fuel',
              currentValue: provider.fuel,
              lastValueChange: provider.fuelDifference,
              onTap: () {
                provider.addFuel(10);
              },
            ),
          ],
      ),
    );
  }
}