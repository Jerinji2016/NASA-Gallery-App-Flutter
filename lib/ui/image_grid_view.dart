import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nasa_gallery/main.dart';
import 'package:nasa_gallery/modals/image_data.dart';

import '../routes.dart';

class ImageGridView extends StatelessWidget {
  const ImageGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = DataProvider.of(context);
    ImageDataIterable images = dataProvider.images;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "NASA Gallery App",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: GridView.builder(
          itemCount: images.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
          ),
          itemBuilder: (context, index) {
            ImageData image = images.elementAt(index);
            return _GridImageTile(image: image);
          },
        ),
      ),
    );
  }
}

class _GridImageTile extends StatelessWidget {
  final ImageData image;

  const _GridImageTile({
    Key? key,
    required this.image,
  }) : super(key: key);

  void _showImageDetails(BuildContext context) {
    Navigator.pushNamed(context, Routes.imageDetails, arguments: image);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showImageDetails(context),
      child: Hero(
        tag: image.key,
        child: CachedNetworkImage(
          imageUrl: image.url,
          fit: BoxFit.cover,
          progressIndicatorBuilder: (context, url, progress) {
            return Center(
              child: SizedBox.square(
                dimension: 30.0,
                child: CircularProgressIndicator(
                  value: progress.progress,
                ),
              ),
            );
          },
          errorWidget: (context, url, error) {
            return const Text("Failed");
          },
        ),
      ),
    );
  }
}
