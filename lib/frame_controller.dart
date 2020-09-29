
import 'dart:async';

class FrameController {
  StreamController<dynamic> _controller;

  FrameController(Duration duration) {
    _controller = new StreamController.broadcast(sync: true);
    _controller.addStream(Stream.periodic(duration, (int value) {
      print('tick $value');
      return value;
    }));
  }

  Stream<dynamic> get onFrame => _controller.stream;
  void dispose() {
    _controller.close();
    _controller = null;
  }
}