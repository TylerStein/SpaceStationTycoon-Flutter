import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:space_station_tycoon/models/modules/module.dart';

@immutable
class UnlockState {
  final BuiltList<ModuleTemplate> templateUnlocks;
  final BuiltList<SubmoduleTemplate> submoduleUnlocks;

  UnlockState({
    @required this.templateUnlocks,
    @required this.submoduleUnlocks,
  });

  factory UnlockState.createDefault() => UnlockState(
      templateUnlocks: BuiltList<ModuleTemplate>(),
      submoduleUnlocks: BuiltList<SubmoduleTemplate>(),
    );

  
}