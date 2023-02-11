import 'package:flutter/material.dart';

import 'ui/image_details_view.dart';
import 'ui/image_grid_view.dart';

class Routes {
  Routes._();

  static const String imageGrid = "/";
  static const String imageDetails = "image-details";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    String? name = settings.name;

    Widget child = const ImageGridView();

    if (name == imageDetails) {
      child = const ImageDetailsView();
    }

    return MaterialPageRoute(
      builder: (context) => child,
    );
  }
}
