import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:space_station_tycoon/models/log_model.dart';
import 'package:space_station_tycoon/redux/state/state.dart';

@immutable
class LogTabViewModel {
  final BuiltList<LogEvent> logs;

  LogTabViewModel({
    @required this.logs,
  });

  @override
  int get hashCode => logs.hashCode;

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is LogTabViewModel &&
    other.logs == logs;

  factory LogTabViewModel.fromStore(Store<GameState> store) =>
    LogTabViewModel(
      logs: store.state.metadataState.logs,
    );
}

class LogTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<GameState, LogTabViewModel>(
      converter: (Store<GameState> store) => LogTabViewModel.fromStore(store),
      builder: (BuildContext context, LogTabViewModel viewModel) =>
        ListView.builder(
          itemCount: viewModel.logs.length,
          itemBuilder: (BuildContext context, int index) => buildRow(context, viewModel.logs[index]),
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