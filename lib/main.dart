import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const NASAGalleryApp(),
  );
}

class NASAGalleryApp extends StatelessWidget {
  const NASAGalleryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
