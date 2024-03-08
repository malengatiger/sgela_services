import 'dart:async';

import 'package:sgela_services/data/branding.dart';

class CompletionStreamHandler {

  final StreamController<bool> _streamController = StreamController.broadcast();
  Stream<bool> get registrationStream => _streamController.stream;

  void setCompleted() {
    _streamController.sink.add(true);
  }
  void setStart() {
    _streamController.sink.add(false);
  }

  final StreamController<Branding> _brandingStreamController = StreamController.broadcast();
  Stream<Branding> get brandingStream => _brandingStreamController.stream;

  void setBranding(Branding branding) {
    _brandingStreamController.sink.add(branding);
  }

}
