import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:space_station_tycoon/models/id.dart';

class _ModuleVisitorBinding {
  ID moduleID;
  ID visitorID;

  _ModuleVisitorBinding({
    @required this.moduleID,
    @required this.visitorID,
  });

  @override
  int get hashCode => moduleID.hashCode ^ visitorID.hashCode;

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is _ModuleVisitorBinding &&
    other.moduleID == moduleID &&
    other.visitorID == visitorID;
}

class ModuleVisitorBindingState {
  BuiltList<_ModuleVisitorBinding> moduleVisitorBinding;

  ModuleVisitorBindingState({
    @required this.moduleVisitorBinding,
  });

  ModuleVisitorBindingState copyWith({
    BuiltList<_ModuleVisitorBinding> moduleVisitorBinding,
  }) => ModuleVisitorBindingState(
    moduleVisitorBinding: moduleVisitorBinding ?? this.moduleVisitorBinding,
  );

  factory ModuleVisitorBindingState.createDefault() =>
    ModuleVisitorBindingState(
      moduleVisitorBinding: BuiltList<_ModuleVisitorBinding>(),
    );

  @override
  int get hashCode => moduleVisitorBinding.hashCode;

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is ModuleVisitorBindingState &&
    other.moduleVisitorBinding == moduleVisitorBinding;

  ModuleVisitorBindingState withRemovedVisitor(ID visitorID) {
    ListBuilder<_ModuleVisitorBinding> builder = moduleVisitorBinding.toBuilder();
    builder.removeWhere((_ModuleVisitorBinding binding) => binding.visitorID == visitorID);
    return ModuleVisitorBindingState(moduleVisitorBinding: builder.build());
  }

  ModuleVisitorBindingState withRemovedModule(ID moduleID) {
    ListBuilder<_ModuleVisitorBinding> builder = moduleVisitorBinding.toBuilder();
    builder.removeWhere((_ModuleVisitorBinding binding) => binding.moduleID == moduleID);
    return ModuleVisitorBindingState(moduleVisitorBinding: builder.build());
  }

  ModuleVisitorBindingState withRemoved({
    @required ID visitorID,
    @required ID moduleID,
  }) {
    ListBuilder<_ModuleVisitorBinding> builder = moduleVisitorBinding.toBuilder();
    builder.removeWhere((_ModuleVisitorBinding binding) =>
      binding.moduleID == moduleID &&
      binding.visitorID == visitorID,
    );
    return ModuleVisitorBindingState(moduleVisitorBinding: builder.build());
  }

  ModuleVisitorBindingState withAdded({
    @required ID visitorID,
    @required ID moduleID,
  }) {
    ListBuilder<_ModuleVisitorBinding> builder = moduleVisitorBinding.toBuilder();
    builder.add(_ModuleVisitorBinding(
      moduleID: moduleID,
      visitorID: visitorID,
    ));
    return ModuleVisitorBindingState(moduleVisitorBinding: builder.build());
  }

  Set<ID> getModuleVisitors(ID moduleID) {
    return this.moduleVisitorBinding
      .where((binding) => binding.moduleID == moduleID)
      .map((binding) => binding.visitorID)
      .toSet();
  }
  
  Set<ID> getVisitorModules(ID visitorID) {
    return this.moduleVisitorBinding
      .where((binding) => binding.visitorID == visitorID)
      .map((binding) => binding.moduleID)
      .toSet();
  }
}