// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    "Read asset file test",
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      String data = await rootBundle.loadString(
        'assets/data.json',
      );
      var json = jsonDecode(data);
      expect(json.runtimeType, List);
      expect(json.length, greaterThan(0));
    },
  );
}
