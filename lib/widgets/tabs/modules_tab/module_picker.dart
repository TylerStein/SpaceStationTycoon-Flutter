import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:space_station_tycoon/models/modules/module.dart';
import 'package:space_station_tycoon/widgets/providers/modules_provider.dart';
import 'package:space_station_tycoon/widgets/providers/resources_provider.dart';
import 'package:space_station_tycoon/widgets/providers/unlocks_provider.dart';

class ModulePicker extends StatelessWidget {
  final ModulesProvider modulesProvider;
  final UnlocksProvider unlocksProvider;
  final ModuleLocation locationFilter;
  final Function() onClose;

  ModulePicker({
    @required this.modulesProvider,
    @required this.unlocksProvider,
    @required this.onClose,
    this.locationFilter,
  });

  @override
  Widget build(BuildContext context) {
    List<ModuleTemplate> filteredModules;
    if (this.locationFilter != null) {
      filteredModules = unlocksProvider.templateUnlocks.where((template) => template.moduleLocation == locationFilter).toList();
    } else {
      filteredModules = unlocksProvider.templateUnlocks;
    }

    return Container(
      padding: const EdgeInsets.all(24),
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 6.0, offset: Offset(0, -6)),
        ]
      ),
      child: Consumer<ResourcesProvider>(
        builder: (BuildContext context, ResourcesProvider resources, Widget child) => ListView.separated(
          itemCount: filteredModules.length,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (BuildContext context, int index) => Container(width: 12,),
          itemBuilder: (BuildContext context, int index) => _buildModuleSquare(
            context: context,
            template: filteredModules[index],
            resourcesProvider: resources,
            onTap: (context, template) {
              resources.addCredits(-1 * template.baseCreditCost);
              modulesProvider.addModule(template);
              onClose();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildModuleSquare({
    BuildContext context,
    ModuleTemplate template,
    ResourcesProvider resourcesProvider,
    Function(BuildContext context, ModuleTemplate template) onTap,
  }) {
    bool canAfford = resourcesProvider.credits > template.baseCreditCost;
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