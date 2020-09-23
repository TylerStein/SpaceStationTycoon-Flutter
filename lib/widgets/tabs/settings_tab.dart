import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_station_tycoon/widgets/providers/metadata_provider.dart';

class SettingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MetadataProvider>(
      builder: (BuildContext context, MetadataProvider metadataProvider, Widget child) => 
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                'Settings',
                style: Theme.of(context).textTheme.headline4,
              )
            ),
          ],
      ),
    );
  }
}