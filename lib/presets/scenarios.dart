import 'package:built_collection/built_collection.dart';
import 'package:space_station_tycoon/models/modules/module_factory.dart';
import 'package:space_station_tycoon/models/modules/templates/dock_module.dart';
import 'package:space_station_tycoon/models/modules/templates/fueling_module.dart';
import 'package:space_station_tycoon/models/modules/templates/repair_module.dart';
import 'package:space_station_tycoon/models/quests/quest.dart';
import 'package:space_station_tycoon/redux/state/state.dart';
import 'package:space_station_tycoon/redux/state/states.dart';

class GameStateScenarios {
  static GameState buildSimpleGameStateScenario() {
    return GameState.createDefault().copyWith(
      resourceState: ResourceState.createDefault()
        .withAddCredits(500)
        .withAddFuel(500)
        .withAddRepairParts(500),
      unlockState: UnlockState.createDefault().copyWith(
        templateUnlocks: BuiltList.of([
          DockModuleTemplate(),
        ]),
        submoduleUnlocks: BuiltList.of([
          FuelingSubmoduleTemplate(),
          RepairSubmoduleTemplate(),
        ]),
      ),
      moduleState: BuiltModulesState.createDefault().copyWith(
        maxInteriorModules: 3,
        maxExteriormodules: 3,
        moduleStateTree: ModuleStateTree.withStates([
          ModuleFactory.createDefaultModuleTemplateState<DockModuleTemplate>(
            submoduleStates: [
              ModuleFactory.createDefaultSubmoduleTemplateState<FuelingSubmoduleTemplate, DockModuleTemplate>(),
            ]
          ),
        ]),
      ),
      questState: QuestState.createDefault().copyWith(
        activeQuestsBuilt: BuiltList.of([
          Quest(
            title: "Get Money, Make Money",
            description: "Prove you can get credits, then get some more",
            useTargetCredits: true,
            targetCredits: 500,
            useRewardCredits: true,
            rewardCredits: 500,
          ),
        ]),
      ),
    );
  }
}