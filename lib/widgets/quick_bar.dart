import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:space_station_tycoon/widgets/providers/metadata_provider.dart';
import 'package:space_station_tycoon/widgets/providers/resources_provider.dart';

class QuickBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<MetadataProvider, ResourcesProvider>( 
      builder: (BuildContext context, MetadataProvider metadata, ResourcesProvider resources, Widget child) =>
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Day
              Icon(Icons.calendar_today, size: 12),
              Text(metadata.data.day.toString()),
              Spacer(),
              // Credits
              Icon(Icons.attach_money, size: 12),
              Text(resources.data.credits.value.toString()),
              Spacer(),
              // Fuel
              Icon(Icons.star, size: 12),
              Text('9999k'),
              Spacer(),
              // Parts
              Icon(FontAwesome.wrench, size: 12),
              Text('9999k'),
              Spacer(),
              // Goods
              Icon(Icons.shopping_cart, size: 12),
              Text('9999k'),
            ],
          ),
        ),
    );
  }
}