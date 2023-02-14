import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nasa_gallery/provider/data_provider.dart';
import 'package:nasa_gallery/themes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'routes.dart';

late SharedPreferences preferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String data = await rootBundle.loadString('assets/data.json');
  preferences = await SharedPreferences.getInstance();

  runApp(
    NASAGalleryApp(
      data: data,
    ),
  );
}

class NASAGalleryApp extends StatelessWidget {
  final String data;

  const NASAGalleryApp({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppDataProvider provider = AppDataProvider(data: data);

    return ChangeNotifierProvider<AppDataProvider>(
      create: (context) => provider,
      child: Consumer<AppDataProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: Routes.onGenerateRoute,
            initialRoute: Routes.imageGrid,
            themeMode: AppDataProvider.of(context, listen: true).theme,
            theme: lightTheme,
            darkTheme: darkTheme,
            builder: (context, child) => SafeArea(child: child!),
          );
        },
      ),
    );
  }
}
