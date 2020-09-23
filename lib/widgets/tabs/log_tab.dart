import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_station_tycoon/models/log_model.dart';
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

  Widget buildRow(BuildContext context, LogEvent logEvent) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: logIcon(logEvent.entryType),
            ),
            Flexible(
              child: Text(logEvent.details),
            ),
          ],
        ),
      ),
    );
  }

  Widget logIcon(LogEventType eventType) {
    switch (eventType) {
      case LogEventType.info: return Icon(Icons.info);
      case LogEventType.arrival: return Icon(Icons.flight_land);
      case LogEventType.departure: return Icon(Icons.flight_takeoff);
      case LogEventType.dissatisfied: return Icon(Icons.sentiment_dissatisfied);
      case LogEventType.satisfied: return Icon(Icons.sentiment_satisfied);
      default: return Icon(Icons.help);
    }
  }
}