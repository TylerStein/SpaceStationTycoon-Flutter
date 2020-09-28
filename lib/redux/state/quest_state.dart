
import 'package:flutter/foundation.dart';

@immutable
class QuestState {
  QuestState();

  @override
  int get hashCode => 0;

  @override
  operator ==(Object other) =>
    identical(this, other) ||
    other is QuestState;

  factory QuestState.createDefault() =>
    QuestState();
}