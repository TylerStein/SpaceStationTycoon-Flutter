import 'package:space_station_tycoon/redux/state/states.dart';

class SetAssetStateAction {
  final AssetState state;
  SetAssetStateAction(this.state);
}

class SetVisitorStateAction {
  final VisitorState state;
  SetVisitorStateAction(this.state);
}

class SetUnlockStateAction {
  final UnlockState state;
  SetUnlockStateAction(this.state);
}

class SetTimeStateAction {
  final TimeState state;
  SetTimeStateAction(this.state);
}

class SetResourceStateAction {
  final ResourceState state;
  SetResourceStateAction(this.state);
}

class SetQuestStateAction {
  final QuestState state;
  SetQuestStateAction(this.state);
}

class SetBuiltModulesStateAction {
  final BuiltModulesState state;
  SetBuiltModulesStateAction(this.state);
}

class SetMetadataStateAction {
  final MetadataState state;
  SetMetadataStateAction(this.state);
}