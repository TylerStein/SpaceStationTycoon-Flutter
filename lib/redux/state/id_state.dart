import 'package:meta/meta.dart';
import 'package:space_station_tycoon/models/id.dart';

@immutable
class IDState {
  final IDProvider shipIDProvider;
  final IDProvider moduleIDProvider;

  ID get shipID => shipIDProvider.unique();
  ID get moduleID => moduleIDProvider.unique();

  IDState({
    @required this.shipIDProvider,
    @required this.moduleIDProvider,
  });

  @override
  int get hashCode => 0;

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is IDState;

  factory IDState.createDefault() => IDState(
    shipIDProvider: IDProvider(),
    moduleIDProvider: IDProvider(),
  );
}