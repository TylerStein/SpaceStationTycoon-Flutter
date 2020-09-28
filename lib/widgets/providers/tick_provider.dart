import 'dart:async';
import 'package:flutter/widgets.dart';

class TickStreamController {
  StreamController<int> tickStreamController;
  final Duration duration;

  TickStreamController({
    @required this.duration,
  }) {
    this.tickStreamController = new StreamController.broadcast(onListen: () {
      print('onListen');
    }, onCancel: () {
      print('onCancel');
    }, sync: true);
  }

  void startTicker() {
    this.tickStreamController.addStream(Stream.periodic(duration, (count) => count).asBroadcastStream());
  }

  void onDispose() {
    tickStreamController.close();
  }
}

@immutable
class TickProvider extends InheritedWidget {
  final TickStreamController tickState;
  final Widget child;

  Stream<int> get stream => tickState.tickStreamController.stream;

  TickProvider({
    @required this.child,
    @required this.tickState,
  }) {
    tickState.startTicker();
  }

  @override
  bool updateShouldNotify(TickProvider oldWidget) {
    return oldWidget.tickState != tickState;
  }

  static TickProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TickProvider>();
  }
}