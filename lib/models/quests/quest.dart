import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import 'package:space_station_tycoon/models/modules/module.dart';
import 'package:space_station_tycoon/redux/actions/state_actions.dart';
import 'package:space_station_tycoon/redux/state/state.dart';

class Quest {
  bool isComplete;

  String title;
  String description;

  bool useTargetCredits;
  int targetCredits;

  bool useTargetModule;
  List<ModuleTemplate> targetModules;

  bool useRewardCredits;
  int rewardCredits;

  bool useRewardModuleUnlock;
  List<ModuleTemplate> rewardModuleUnlocks;

  bool useRewardSubmoduleUnlock;
  List<SubmoduleTemplate> rewardSubmoduleUnlocks;

  Quest({
    @required this.title,
    @required this.description,
    this.useTargetCredits = false,
    this.targetCredits,
    this.useTargetModule = false,
    this.targetModules,
    this.useRewardCredits = false,
    this.rewardCredits,
    this.useRewardModuleUnlock = false,
    this.rewardModuleUnlocks,
    this.useRewardSubmoduleUnlock = false,
    this.rewardSubmoduleUnlocks,
    this.isComplete = false,
  })  : assert(useTargetCredits == true ? targetCredits != null : true),
        assert(useTargetModule == true ? targetModules != null : true),
        assert(useTargetCredits == true ? targetCredits != null : true),
        assert(
            useRewardModuleUnlock == true ? rewardModuleUnlocks != null : true),
        assert(useRewardSubmoduleUnlock == true
            ? rewardSubmoduleUnlocks != null
            : true);

  void updateQuest(Store<GameState> store) {
    if (!isComplete && _checkQuestCompletion(store.state) == true) {
      isComplete = true;
      _giveReward(store);
    }
  }

  void _giveReward(Store<GameState> store) {
    if (useRewardCredits == true) {
      var action = SetResourceStateAction(
        store.state.resourceState.withAddCredits(rewardCredits),
      );
      store.dispatch(action);
    }

    if (useRewardModuleUnlock == true) {
      var builder = store.state.unlockState.templateUnlocks.toBuilder();
      builder.addAll(rewardModuleUnlocks.where((module) =>
          store.state.unlockState.templateUnlocks.contains(module) == false));
      var action = SetUnlockStateAction(
          store.state.unlockState.copyWith(templateUnlocks: builder.build()));
      store.dispatch(action);
    }

    if (useRewardSubmoduleUnlock == true) {
      var builder = store.state.unlockState.submoduleUnlocks.toBuilder();
      builder.addAll(rewardSubmoduleUnlocks.where((submodule) =>
          store.state.unlockState.submoduleUnlocks.contains(submodule) ==
          false));
      var action = SetUnlockStateAction(
          store.state.unlockState.copyWith(submoduleUnlocks: builder.build()));
      store.dispatch(action);
    }
  }

  bool _checkQuestCompletion(GameState gameState) {
    if (useTargetCredits) {
      if (gameState.resourceState.credits.value < targetCredits) {
        return false;
      }
    }

    if (useTargetModule) {
      for (ModuleTemplate template in targetModules) {
        if (gameState.moduleState.hasModuleByType(template.runtimeType) ==
            false) {
          return false;
        }
      }
    }

    return true;
  }
}
