import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:space_station_tycoon/widgets/providers/metadata_provider.dart';

class LogTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MetadataProvider>(
      builder: (BuildContext context, MetadataProvider provider, Widget child) =>
        ListView.builder(
          itemCount: provider.data.logs.length,
          itemBuilder: (BuildContext context, int index) => buildRow(context, provider.data.logs[index]),
        ),
    );
  }

  Widget buildRow(BuildContext context, String content) {
    return Text(content);
  }
}