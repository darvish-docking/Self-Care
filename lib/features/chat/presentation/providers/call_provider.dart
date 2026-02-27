import 'dart:async';
import 'package:flutter/material.dart';

class CallProvider extends ChangeNotifier {
  bool isMicOn = true;
  bool isVideoOn = true;
  int seconds = 0;
  Timer? _timer;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      seconds++;
      notifyListeners();
    });
  }

  void toggleMic() {
    isMicOn = !isMicOn;
    notifyListeners();
  }

  void toggleVideo() {
    isVideoOn = !isVideoOn;
    notifyListeners();
  }

  String get formattedTime {
    final mins = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$mins:$secs";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}