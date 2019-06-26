import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wxvoice/wxvoice.dart';

void main() {
  const MethodChannel channel = MethodChannel('wxvoice');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await Wxvoice.platformVersion, '42');
  });
}
