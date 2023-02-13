import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nasa_gallery/modals/image_data.dart';
import 'package:nasa_gallery/widgets/theme_changer_icon.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../provider/data_provider.dart';
import '../routes.dart';

class ImageGridView extends StatelessWidget {
  const ImageGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppDataProvider provider = AppDataProvider.of(context);
    ImageDataIterable images = provider.images;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: _CustomHeaderDelegate(),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  ImageData image = images.elementAt(index);
                  return _GridImageTile(image: image);
                },
                childCount: images.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 2.0,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 60.0),
                FutureBuilder<PackageInfo>(
                  future: PackageInfo.fromPlatform(),
                  builder: (context, packageInfo) {
                    if (packageInfo.connectionState == ConnectionState.done && packageInfo.data != null) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                        child: Text(
                          "version ${packageInfo.data!.version}",
                          style: TextStyle(
                            color: Theme.of(context).disabledColor,
                            fontSize: 12.0,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ],
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
        child: Material(
          color: Colors.transparent,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(4.0),
            ),
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
        ),
      ),
    );
  }
}

class _CustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    AppDataProvider provider = AppDataProvider.of(context);
    int imagesCount = provider.images.length;
    double scale = 1 - shrinkOffset / maxExtent;

    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
            child: ThemeChangerIcon(
              key: UniqueKey(),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            height: minExtent * max(0.8, scale),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'NASA Gallery App',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 28.0 * max(0.7, scale),
                          ),
                    ),
                    SingleChildScrollView(
                      child: Opacity(
                        opacity: max(0.0, scale / 2),
                        child: Text(
                          '$imagesCount photos',
                          style: TextStyle(
                            color: Theme.of(context).disabledColor,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => 200.0;

  @override
  double get minExtent => 120.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}
