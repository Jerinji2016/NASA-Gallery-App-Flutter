import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nasa_gallery/provider/data_provider.dart';

import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String data = await rootBundle.loadString('assets/data.json');

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
    return SafeArea(
      child: DataProvider(
        data: data,
        child: MaterialApp(
          onGenerateRoute: Routes.onGenerateRoute,
          initialRoute: Routes.imageGrid,
          theme: ThemeData(
            fontFamily: "Poppins",
          ),
        ),
      ),
    );
  }
}
