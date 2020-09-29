import 'package:space_station_tycoon/models/log_model.dart' show LogEvent;

abstract class LoggableAction {
  LogEvent get logEvent;
}