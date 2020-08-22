import 'dart:async';
import 'package:flutter/widgets.dart';

class TickState {
  StreamController<int> tickStreamController;
  Duration duration;
  int frame;

  @override
  int get hashCode => duration.hashCode ^ frame.hashCode ^ tickStreamController.hashCode;

  @override
  operator ==(Object other) =>
    identical(other, this) ||
    other is TickState &&
    other.tickStreamController == tickStreamController &&
    other.duration == duration &&
    other.frame == frame;

  TickState({
    @required this.duration,
    this.frame = 0,
  }) {
    this.tickStreamController = new StreamController.broadcast(onListen: () {
      print('onListen');
    }, onCancel: () {
      print('onCancel');
    }, sync: true);
  }

  void startTicker() {
    this.tickStreamController.addStream(Stream.periodic(duration, (count) => count).asBroadcastStream());
    this.tickStreamController.stream.listen((count) {
      onTick(count);
    });
  }

  void onTick(int frameCount) {
    this.frame = frameCount;
  }

  void onDispose() {
    tickStreamController.close();
  }
}

@immutable
class TickProvider extends InheritedWidget {
  final TickState tickState;
  final Widget child;

  int get frame => tickState.frame;
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