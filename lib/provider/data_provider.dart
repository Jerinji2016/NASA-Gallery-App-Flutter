import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nasa_gallery/main.dart';
import 'package:provider/provider.dart';

import '../modals/image_data.dart';

/// Global Data Provider
class AppDataProvider extends ChangeNotifier {
  static final AppDataProvider _mInstance = AppDataProvider._internal();

  static const String _themeKey = "app_theme";

  factory AppDataProvider({required String data}) {
    List items = jsonDecode(data);
    _mInstance._images.clear();
    for (Map<String, dynamic> item in items) {
      _mInstance._images.add(ImageData(item));
    }
    int? themeIndex = preferences.getInt(_themeKey);
    if (themeIndex != null) {
      _mInstance._theme = ThemeMode.values[themeIndex];
    }

    return _mInstance;
  }

  AppDataProvider._internal();

  static AppDataProvider of(
    BuildContext context, {
    bool listen = false,
  }) =>
      Provider.of<AppDataProvider>(context, listen: listen);

  final ImageDataList _images = [];

  ImageDataIterable get images => _images;

  ThemeMode _theme = ThemeMode.system;

  ThemeMode get theme => _theme;

  void toggleTheme() {
    debugPrint("AppDataProvider.toggleTheme: current theme: $_theme");
    int index = ThemeMode.values.indexWhere((element) => element == _theme);
    int nextIndex = (index + 1) % ThemeMode.values.length;
    _theme = ThemeMode.values[nextIndex];
    preferences.setInt(_themeKey, nextIndex);
    debugPrint("AppDataProvider.toggleTheme: next theme: $_theme");
    notifyListeners();
  }
}
