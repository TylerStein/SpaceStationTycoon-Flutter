import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:space_station_tycoon/models/modules/module.dart';
import 'package:space_station_tycoon/models/modules/module_factory.dart';
import 'package:space_station_tycoon/widgets/generic/module_detail.dart';
import 'package:space_station_tycoon/widgets/providers/modules_provider.dart';
import 'package:space_station_tycoon/widgets/providers/resources_provider.dart';
import 'package:space_station_tycoon/widgets/providers/unlocks_provider.dart';

class SubmodulePicker extends StatelessWidget {
  final ModulesProvider modulesProvider;
  final UnlocksProvider unlocksProvider;
  final ModuleState parentModuleState;
  final Function() onClose;

  SubmodulePicker({
    @required this.modulesProvider,
    @required this.unlocksProvider,
    @required this.onClose,
    @required this.parentModuleState,
  });

  @override
  Widget build(BuildContext context) {
    List<SubmoduleTemplate> filteredModules = unlocksProvider.submoduleUnlocks
      .where((template) => template.parentType == parentModuleState.template.runtimeType)
      .toList();

    return ModuleDetail(
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
              SubmoduleState submodule = ModuleFactory.createDefaultSubmoduleTemplateStateFrom(template);
              parentModuleState.addSubmodule(submodule);
              onClose();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildModuleSquare({
    BuildContext context,
    SubmoduleTemplate template,
    ResourcesProvider resourcesProvider,
    Function(BuildContext context, SubmoduleTemplate template) onTap,
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