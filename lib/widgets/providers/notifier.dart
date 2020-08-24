import 'package:flutter/cupertino.dart';

abstract class GameStateNotifier extends ChangeNotifier {
  bool isDirty;
  void notifyOrMarkDirty(bool notify) {
    if (notify) {
      notifyListeners();
    } else {
      isDirty = true;
    }
  }

  void notifyIfDirty() {
    if (isDirty) {
      notifyListeners();
    }
  }
}