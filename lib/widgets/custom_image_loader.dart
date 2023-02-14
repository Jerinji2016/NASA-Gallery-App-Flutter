import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nasa_gallery/widgets/custom_loading_shimmer.dart';

class CustomImageLoader extends StatelessWidget {
  final String url;
  final double borderRadius;
  final double? height, width;

  const CustomImageLoader({
    Key? key,
    required this.url,
    this.borderRadius = 0.0,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(borderRadius),
      ),
      child: CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (context, url, progress) {
          return Column(
            children: [
              Expanded(
                child: CustomLoadingShimmer(
                  key: UniqueKey(),
                ),
              ),
              LinearProgressIndicator(
                value: progress.progress,
              )
            ],
          );
        },
        errorWidget: (context, url, error) {
          return Container(
            color: Theme.of(context).cardColor,
            child: const Center(
              child: Icon(
                Icons.wifi_off_outlined,
                color: Colors.red,
              ),
            ),
          );
        },
      ),
    );
  }
}
