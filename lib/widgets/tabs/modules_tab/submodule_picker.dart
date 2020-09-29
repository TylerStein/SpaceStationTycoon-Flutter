import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:space_station_tycoon/models/modules/module.dart';
import 'package:space_station_tycoon/redux/actions/state_actions.dart';
import 'package:space_station_tycoon/redux/state/state.dart';

@immutable
class SubModulePickerViewModel {
  final BuiltList<SubmoduleTemplate> templateUnlocks;
  final int credits;

  final Function(SubmoduleTemplate module) onBuyModule;

  SubModulePickerViewModel({
    @required this.templateUnlocks,
    @required this.credits,
    @required this.onBuyModule,
  });

  @override
  int get hashCode =>
    templateUnlocks.hashCode ^
    credits.hashCode ^
    onBuyModule.hashCode;

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is SubModulePickerViewModel &&
    other.templateUnlocks == templateUnlocks &&
    other.credits == credits &&
    other.onBuyModule == onBuyModule;

  factory SubModulePickerViewModel.fromStore(Store<GameState> store, ModuleState parentModuleState) {
    BuiltList<SubmoduleTemplate> filteredModules = store.state.unlockState.submoduleUnlocks
      .where((template) => template.parentType == parentModuleState.template.runtimeType)
      .toBuiltList();

    return SubModulePickerViewModel(
      templateUnlocks: filteredModules,
      credits: store.state.resourceState.credits.value,
      onBuyModule: (SubmoduleTemplate module) {
        store.dispatch(SetResourceStateAction(
          store.state.resourceState.withAddCredits(-1 * module.baseCreditCost),
        ));

        // SubmoduleState submodule = ModuleFactory.createDefaultSubmoduleTemplateStateFrom(template);
        // parentModuleState.addSubmodule(submodule);
      }
    );
  }
}

class SubmodulePicker extends StatelessWidget {
  final ModuleState parentModuleState;
  final Function() onClose;

  SubmodulePicker({
    @required this.onClose,
    @required this.parentModuleState,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: (Store<GameState> store) => SubModulePickerViewModel.fromStore(store, parentModuleState),
      builder: (BuildContext context, SubModulePickerViewModel viewModel) => ListView.separated(
        itemCount: viewModel.templateUnlocks.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (BuildContext context, int index) => Container(width: 12),
        itemBuilder: (BuildContext context, int index) => _buildModuleSquare(
          context: context,
          template: viewModel.templateUnlocks[index],
          onTap: (context, template) {
            viewModel.onBuyModule(template);
            onClose();
          },
        ),
      ),
    );
  }

  Widget _buildModuleSquare({
    BuildContext context,
    SubmoduleTemplate template,
    SubModulePickerViewModel viewModel,
    Function(BuildContext context, SubmoduleTemplate template) onTap,
  }) {
    bool canAfford = viewModel.credits > template.baseCreditCost;
    return Container(
      margin: const EdgeInsets.all(8),
      child: RaisedButton(
        onPressed: canAfford ?
          () => onTap(context, template)
          : null,
        child: Text('${template.shortName} (${template.baseCreditCost}C)'),
      )
    );
  }
}