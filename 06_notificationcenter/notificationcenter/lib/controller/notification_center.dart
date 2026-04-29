import 'dart:async';

class NotificationCenter {
  final StreamController<String> _controller =
      StreamController<String>.broadcast();

  void pushNotification(String message) {
    if (!_controller.isClosed) {
      // Kapalı değilse ekle
      _controller.add(message);
    }
  }

  Stream<String> get stream => _controller.stream;

  void dispose() {
    _controller.close();
  }
}
