import 'package:space_station_tycoon/models/visitors/ship.dart';
import 'package:space_station_tycoon/models/visitors/templates/t1_ship_templates.dart';

class ShipFactory {
  static ShipTemplate generateTemplate(List<ShipRequirementTemplate> requirements) {
    return T1ShipTemplate(requirements);
  }
}