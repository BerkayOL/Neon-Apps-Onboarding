import 'dart:async';

//Bildirimler için bir merkez oluşturduk.
class NotificationCenter {
  final StreamController<String> _controller =
      StreamController<String>.broadcast();
  pushnotification(String message) {
    _controller.add(message);
  }

  get stream => _controller.stream;
  dispose() {
    _controller.close();
  }
}

final notificationCenter = NotificationCenter();
