
import 'dart:async';

class FrameController {
  StreamController<dynamic> _controller;

  FrameController(Duration duration) {
    _controller = new StreamController.broadcast();
    _controller.addStream(Stream.periodic(duration));
  }

  Stream<dynamic> get onFrame => _controller.stream;
  void dispose() {
    _controller.close();
    _controller = null;
  }
}