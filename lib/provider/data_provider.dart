import 'dart:convert';

import 'package:flutter/material.dart';

import '../modals/image_data.dart';

/// Global Data Provider
class DataProvider extends InheritedWidget {
  final ImageDataList _images = [];

  ImageDataIterable get images => _images;

  DataProvider({
    Key? key,
    required String data,
    required Widget child,
  }) : super(key: key, child: child) {
    List items = jsonDecode(data);
    for (Map<String, dynamic> item in items) {
      _images.add(ImageData(item));
    }
  }

  static DataProvider of(BuildContext context) {
    final DataProvider? result = context.dependOnInheritedWidgetOfExactType<DataProvider>();
    assert(result != null, 'No DataProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(DataProvider oldWidget) {
    return false;
  }
}
