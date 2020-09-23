import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_station_tycoon/models/modules/module.dart';
import 'package:space_station_tycoon/widgets/providers/modules_provider.dart';
import 'package:space_station_tycoon/widgets/providers/unlocks_provider.dart';
import 'package:space_station_tycoon/widgets/tabs/modules_tab/module_picker.dart';
import 'package:space_station_tycoon/widgets/tabs/modules_tab/submodule_picker.dart';

class ModulesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ModulesProvider, UnlocksProvider>(
      builder: (BuildContext context, ModulesProvider modulesProvider, UnlocksProvider unlocksProvider, Widget child) =>
       Column(
        children: [
          _buildAddRow(
            context,
            'Interior',
            modulesProvider.interiorModules.length,
            modulesProvider.data.maxInteriorModules,
            () {
              PersistentBottomSheetController controller;
              controller = Scaffold.of(context).showBottomSheet(
                (context) => ModulePicker(
                  locationFilter: ModuleLocation.INTERIOR,
                  modulesProvider: modulesProvider,
                  unlocksProvider: unlocksProvider,
                  onClose: () {
                    controller.close();
                  }
                ),
              );
            },
          ),
          _buildModuleGrid<ModuleState>(
            context,
            modulesProvider.interiorModules,
            (context, module) => _buildModuleSquare(
              context,
              module,
              (BuildContext context, ModuleState module) {
                PersistentBottomSheetController controller;
                controller = Scaffold.of(context).showBottomSheet(
                  (context) => SubmodulePicker(
                    parentModuleState: module,
                    modulesProvider: modulesProvider,
                    unlocksProvider: unlocksProvider,
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
            modulesProvider.exteriorModules.length,
            modulesProvider.data.maxExteriormodules,
            () {
              PersistentBottomSheetController controller;
              controller = Scaffold.of(context).showBottomSheet(
                (context) => ModulePicker(
                  locationFilter: ModuleLocation.EXTERIOR,
                  modulesProvider: modulesProvider,
                  unlocksProvider: unlocksProvider,
                  onClose: () {
                    controller.close();
                  }
                ),
              );
            },
          ),
          _buildModuleGrid<ModuleState>(
            context,
            List.generate(modulesProvider.exteriorModules.length, (index) => modulesProvider.exteriorModules[index]),
            (context, module) => _buildModuleSquare(
              context,
              module,
              (BuildContext context, ModuleState module) {
                PersistentBottomSheetController controller;
                controller = Scaffold.of(context).showBottomSheet(
                  (context) => SubmodulePicker(
                    parentModuleState: module,
                    modulesProvider: modulesProvider,
                    unlocksProvider: unlocksProvider,
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

  Widget _buildModuleGrid<T>(BuildContext context, List<T> modules, Widget Function(BuildContext context, T module) builder) {
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