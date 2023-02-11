import 'package:flutter/material.dart';

import 'routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      onGenerateRoute: Routes.onGenerateRoute,
      initialRoute: Routes.imageGrid,
      theme: ThemeData(
        fontFamily: "Poppins",
      ),
    ),
  );
}
