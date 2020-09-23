import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_station_tycoon/widgets/generic/module_detail.dart';
import 'package:space_station_tycoon/widgets/providers/resources_provider.dart';

class ResourceDetails extends StatelessWidget {
  final String label;

  ResourceDetails({
    Key key,
    @required this.label,
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
                child: Text(label, textAlign: TextAlign.left),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('+'), Text('-')],
              ),
            ],
          )
      ),
    );
  }
}