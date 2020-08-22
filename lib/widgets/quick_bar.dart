import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_station_tycoon/widgets/providers/metadata_provider.dart';
import 'package:space_station_tycoon/widgets/providers/resources_provider.dart';

class QuickBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<MetadataProvider, ResourcesProvider>( 
      builder: (BuildContext context, MetadataProvider metadata, ResourcesProvider resources, Widget child) =>
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text('Day ${metadata.data.day}'),
            ),
            Text(metadata.data.name),
            GestureDetector(
              onTap: () {
                resources.addCredits(100);
              },
              child: Text('${resources.data.credits.value.toString()}C'),
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                print('open settings');
              },
            ),
          ],
        ),
    );
  }
}