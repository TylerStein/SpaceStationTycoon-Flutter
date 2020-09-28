import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:space_station_tycoon/models/modules/module.dart';
import 'package:space_station_tycoon/redux/state/state.dart';
import 'package:space_station_tycoon/widgets/tabs/modules_tab/module_picker.dart';
import 'package:space_station_tycoon/widgets/tabs/modules_tab/submodule_picker.dart';

@immutable
class ModulesTabViewModel {
  final BuiltList<ModuleState> interiorModules;
  final int maxInteriorModules;

  final BuiltList<ModuleState> exteriorModules;
  final int maxExteriorModules;

  ModulesTabViewModel({
    @required this.interiorModules,
    @required this.exteriorModules,
    @required this.maxInteriorModules,
    @required this.maxExteriorModules,
  });

  @override
  int get hashCode => interiorModules.hashCode ^
    exteriorModules.hashCode ^
    maxInteriorModules.hashCode ^
    maxExteriorModules.hashCode;

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is ModulesTabViewModel &&
    other.interiorModules == interiorModules &&
    other.exteriorModules == exteriorModules &&
    other.maxInteriorModules == maxInteriorModules &&
    other.maxExteriorModules == maxExteriorModules;

  factory ModulesTabViewModel.fromStore(Store<GameState> store) =>
    ModulesTabViewModel(
      interiorModules: store.state.moduleState.moduleStateTree.interiorModules,
      exteriorModules: store.state.moduleState.moduleStateTree.exteriorModules,
      maxInteriorModules: store.state.moduleState.maxInteriorModules,
      maxExteriorModules: store.state.moduleState.maxExteriormodules,
    );
}

class ModulesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<GameState, ModulesTabViewModel>(
      converter: (Store<GameState> store) => ModulesTabViewModel.fromStore(store),
      builder: (BuildContext context, ModulesTabViewModel viewModel) =>
       Column(
        children: [
          _buildAddRow(
            context,
            'Interior',
            viewModel.interiorModules.length,
            viewModel.maxInteriorModules,
            () {
              PersistentBottomSheetController controller;
              controller = Scaffold.of(context).showBottomSheet(
                (context) => ModulePicker(
                  locationFilter: ModuleLocation.INTERIOR,
                  onClose: () {
                    controller.close();
                  }
                ),
              );
            },
          ),
          _buildModuleGrid<ModuleState>(
            context,
            viewModel.interiorModules,
            (context, module) => _buildModuleSquare(
              context,
              module,
              (BuildContext context, ModuleState module) {
                PersistentBottomSheetController controller;
                controller = Scaffold.of(context).showBottomSheet(
                  (context) => SubmodulePicker(
                    parentModuleState: module,
                    onClose: () {
                      controller.close();
                    }
                  ),
                );
              }
            ),
          ),
          _buildAddRow(
            context,
            'Exterior',
            viewModel.exteriorModules.length,
            viewModel.maxExteriorModules,
            () {
              PersistentBottomSheetController controller;
              controller = Scaffold.of(context).showBottomSheet(
                (context) => ModulePicker(
                  locationFilter: ModuleLocation.EXTERIOR,
                  onClose: () {
                    controller.close();
                  }
                ),
              );
            },
          ),
          _buildModuleGrid<ModuleState>(
            context,
            viewModel.exteriorModules,
            (context, module) => _buildModuleSquare(
              context,
              module,
              (BuildContext context, ModuleState module) {
                PersistentBottomSheetController controller;
                controller = Scaffold.of(context).showBottomSheet(
                  (context) => SubmodulePicker(
                    parentModuleState: module,
                    onClose: () {
                      controller.close();
                    }
                  ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddRow(BuildContext context, String text, int moduleCount, int maxModules, Function() onAdd) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 12),
      child: Row(
        children: [
          Text(text, style: Theme.of(context).textTheme.headline6,),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: IconButton(
              icon: Icon(Icons.add_circle_outline),
              onPressed: onAdd,
            ),
          )
        ],
      )
    );
  }

  Widget _buildModuleGrid<T>(BuildContext context, BuiltList<T> modules, Widget Function(BuildContext context, T module) builder) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 4,
        children: modules.map((module) => builder(context, module)).toList(),
      ),
    );
  }

  Widget _buildModuleSquare(BuildContext context, ModuleState module, Function(BuildContext context, ModuleState module) onTap) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Material(
        type: MaterialType.card,
        child: InkWell(
          onTap: () => onTap(context, module),
          child: Center(
            child: Text('${module.template.shortName}'),
          ),
        ),
      ),
    );
  }
}