import 'dart:async';

import 'package:flutter/services.dart';

class Wxvoice {
  static const MethodChannel _channel =
      const MethodChannel('wxvoice');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
