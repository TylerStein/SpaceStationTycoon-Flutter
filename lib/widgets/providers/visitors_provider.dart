import 'package:flutter/cupertino.dart';
import 'package:space_station_tycoon/models/provider_models/visitor_model.dart';
import 'package:space_station_tycoon/widgets/providers/notifier.dart';

class VisitorsProvider extends GameStateNotifier {
  VisitorModel data;

  List<Visitor> get allVisitors => data.getAllVisitors();

  VisitorsProvider({
    this.data,
  });

  Visitor getVisitor(VisitorID id) => data.getVisitor(id);
  void addVisitor(Visitor visitor) => data.addVisitor(visitor);
  void removeVisitor(VisitorID id) => data.removeVisitor(id);

  factory VisitorsProvider.createDefault(BuildContext context) =>
    VisitorsProvider(data: VisitorModel.createDefault(context));
}