import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:space_station_tycoon/models/quests/quest.dart';

@immutable
class QuestState {
  QuestState({
    @required this.activeQuestsBuilt,
  });

  final BuiltList<Quest> activeQuestsBuilt;
  List<Quest> get activeQuests => activeQuestsBuilt.toList();

  @override
  int get hashCode => 0;

  @override
  operator ==(Object other) => identical(this, other) || other is QuestState;

  factory QuestState.createDefault() => QuestState(
        activeQuestsBuilt: BuiltList<Quest>(),
      );

  QuestState copyWith({
    BuiltList<Quest> activeQuestsBuilt,
  }) =>
      QuestState(
        activeQuestsBuilt: activeQuestsBuilt ?? this.activeQuestsBuilt,
      );
}
