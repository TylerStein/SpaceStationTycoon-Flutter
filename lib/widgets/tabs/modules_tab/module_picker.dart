import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:space_station_tycoon/models/modules/module.dart';
import 'package:space_station_tycoon/redux/actions/state_actions.dart';
import 'package:space_station_tycoon/redux/state/state.dart';
import 'package:space_station_tycoon/widgets/generic/module_detail.dart';


@immutable
class ModulePickerViewModel {
  final BuiltList<ModuleTemplate> templateUnlocks;
  final int credits;

  final Function(ModuleTemplate module) onBuyModule;

  ModulePickerViewModel({
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
    other is ModulePickerViewModel &&
    other.templateUnlocks == templateUnlocks &&
    other.credits == credits &&
    other.onBuyModule == onBuyModule;

  factory ModulePickerViewModel.fromStore(Store<GameState> store, [ModuleLocation locationFilter]) {
    BuiltList<ModuleTemplate> filteredModules;
    if (locationFilter != null) {
      filteredModules = store.state.unlockState.templateUnlocks.where((template) => template.moduleLocation == locationFilter).toBuiltList();
    } else {
      filteredModules = store.state.unlockState.templateUnlocks;
    }

    return ModulePickerViewModel(
      templateUnlocks: filteredModules,
      credits: store.state.resourceState.credits.value,
      onBuyModule: (ModuleTemplate module) {
        store.dispatch(SetResourceStateAction(
          store.state.resourceState.withAddCredits(-1 * module.baseCreditCost),
        ));

       // modulesProvider.addModule(template);
      }
    );
  }
}

class ModulePicker extends StatelessWidget {
  final ModuleLocation locationFilter;
  final Function() onClose;

  ModulePicker({
    @required this.onClose,
    @required this.locationFilter,
  });

  @override
  Widget build(BuildContext context) {

    return ModuleDetail(
      child: StoreConnector<GameState, ModulePickerViewModel>(
        converter: (Store<GameState> store) => ModulePickerViewModel.fromStore(store, locationFilter),
        builder: (BuildContext context, ModulePickerViewModel viewModel) => ListView.separated(
          itemCount: viewModel.templateUnlocks.length,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (BuildContext context, int index) => Container(width: 12,),
          itemBuilder: (BuildContext context, int index) => _buildModuleSquare(
            context: context,
            template: viewModel.templateUnlocks[index],
            onTap: (context, template) {
              viewModel.onBuyModule(template);
              onClose();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildModuleSquare({
    BuildContext context,
    ModulePickerViewModel viewModel,
    ModuleTemplate template,
    Function(BuildContext context, ModuleTemplate template) onTap,
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