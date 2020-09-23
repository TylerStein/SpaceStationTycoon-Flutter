import 'package:space_station_tycoon/models/provider_models/visitor_model.dart';

enum LogEventType {
  info,
  arrival,
  departure,
  dissatisfied,
  satisfied,
}

class LogEvent {
  final LogEventType entryType;
  final String details;

  LogEvent(this.entryType, this.details);

  factory LogEvent.logInfo(String info) => LogEvent(LogEventType.info, info);
  factory LogEvent.logArrival(Visitor visitor) => LogEvent(LogEventType.arrival, 'Visitor ${visitor.displayName} has arrived at the station.');
  factory LogEvent.logDeparture(Visitor visitor) => LogEvent(LogEventType.departure, 'Visitor ${visitor.displayName} has left the station.');
  factory LogEvent.logDissatisfied(Visitor visitor, String problem) => LogEvent(LogEventType.dissatisfied, 'Visitor ${visitor.displayName} has a problem: $problem');
  factory LogEvent.logSatisfied(Visitor visitor, String reason) => LogEvent(LogEventType.satisfied, 'Visitor ${visitor.displayName} is satisfied: $reason');
}