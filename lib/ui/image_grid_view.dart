import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nasa_gallery/modals/image_data.dart';

import '../provider/data_provider.dart';
import '../routes.dart';

class ImageGridView extends StatelessWidget {
  const ImageGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = DataProvider.of(context);
    ImageDataIterable images = dataProvider.images;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: _CustomHeaderDelegate(),
          ),
          // SliverAppBar(
          //   backgroundColor: Colors.transparent,
          //   automaticallyImplyLeading: false,
          //   actions: <Widget>[new Container()],
          //   expandedHeight: 200.0,
          //   floating: false,
          //   pinned: false,
          //   primary: true,
          //   snap: false,
          //   flexibleSpace: FlexibleSpaceBar.createSettings(
          //     currentExtent: 120.0,
          //     minExtent: 0,
          //     maxExtent: 200.0,
          //     child: FlexibleSpaceBar(
          //       collapseMode: CollapseMode.pin,
          //       titlePadding: const EdgeInsetsDirectional.only(start: 16, bottom: 20),
          //       title: SingleChildScrollView(
          //         child: Column(
          //           mainAxisSize: MainAxisSize.min,
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             const Text(
          //               'NASA Gallery App',
          //               style: TextStyle(
          //                 color: Colors.black,
          //                 fontSize: 18.0,
          //                 fontWeight: FontWeight.w600,
          //               ),
          //             ),
          //             Text(
          //               '${images.length} photos',
          //               style: TextStyle(
          //                 color: Theme.of(context).disabledColor,
          //                 fontSize: 12.0,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
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
    DataProvider dataProvider = DataProvider.of(context);
    int imagesCount = dataProvider.images.length;

    debugPrint("_CustomHeaderDelegate.build: shrink $shrinkOffset");

    double scale = 1 - shrinkOffset / maxExtent;
    debugPrint("_CustomHeaderDelegate.build: scale: $scale");
    debugPrint("_CustomHeaderDelegate.build: scale: ${scale / 2}");

    return Align(
      alignment: Alignment.bottomLeft,
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
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28.0 * max(0.7, scale),
                    fontWeight: FontWeight.w500,
                    height: 1.0,
                  ),
                ),
                SingleChildScrollView(
                  child: Opacity(
                    opacity: max(0.0, scale / 2),
                    child: Text(
                      '$imagesCount photos',
                      style: const TextStyle(
                        color: Color(0xFF3B3B3B),
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
    );
  }

  @override
  double get maxExtent => 200.0;

  @override
  double get minExtent => 120.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}
