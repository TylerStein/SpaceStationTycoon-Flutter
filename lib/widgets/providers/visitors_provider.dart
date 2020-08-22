import 'package:flutter/cupertino.dart';
import 'package:space_station_tycoon/models/provider_models/visitor_model.dart';

class VisitorsProvider extends ChangeNotifier {
  VisitorModel data;

  List<Visitor> get allVisitors => data.getAllVisitors();

  VisitorsProvider({
    this.data,
  });

  Visitor getVisitor(VisitorID id) => data.getVisitor(id);
  void addVisitor(Visitor visitor) => data.addVisitor(visitor);


  factory VisitorsProvider.createDefault(BuildContext context) =>
    VisitorsProvider(data: VisitorModel.createDefault(context));
}