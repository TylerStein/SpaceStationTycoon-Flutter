import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_station_tycoon/widgets/providers/metadata_provider.dart';
import 'package:space_station_tycoon/widgets/providers/modules_provider.dart';
import 'package:space_station_tycoon/widgets/providers/resources_provider.dart';

class OverviewTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer3<MetadataProvider, ResourcesProvider, ModulesProvider>(
      builder: (BuildContext context, MetadataProvider metadataProvider, ResourcesProvider resourcesProvider, ModulesProvider modulesProvider, Widget child) => 
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                metadataProvider.data.name,
                style: Theme.of(context).textTheme.headline4,
              )
            ),
          ],
      ),
    );
  }
}