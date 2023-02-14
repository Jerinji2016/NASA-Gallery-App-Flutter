import 'package:flutter/material.dart';

import 'modals/image_data.dart';
import 'ui/image_details_view/image_details_view.dart';
import 'ui/image_grid_view.dart';

class Routes {
  Routes._();

  static const String imageGrid = "/";
  static const String imageDetails = "image-details";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    String? name = settings.name;

    Widget child = const ImageGridView();

    if (name == imageDetails) {
      var args = settings.arguments;
      assert(args is ImageData, "Need Image Data as argument for $imageDetails");
      child = ImageDetailsView(image: args as ImageData);
    }

    return MaterialPageRoute(
      builder: (context) => child,
    );
  }
}
