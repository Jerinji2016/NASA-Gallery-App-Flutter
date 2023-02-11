import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../modals/image_data.dart';

class ImageDetailsView extends StatelessWidget {
  final ImageData image;

  const ImageDetailsView({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: image.key,
        child: PhotoView(
          imageProvider: NetworkImage(
            image.hdUrl,
          ),
          loadingBuilder: (context, imageChunkEvent) {
            debugPrint("ImageDetailsView.build: $imageChunkEvent");
            return const Center(
              child: SizedBox.square(
                dimension: 30.0,
                child: CircularProgressIndicator(),
              ),
            );
          },
          errorBuilder: (context, url, error) {
            return const Text("Failed to load Image");
          },
        ),
      ),
    );
  }
}
