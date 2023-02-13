import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
                child: Shimmer.fromColors(
                  highlightColor: Colors.grey[300]!,
                  baseColor: Colors.grey[400]!,
                  period: const Duration(milliseconds: 800),
                  child: Center(
                    child: Container(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              LinearProgressIndicator(
                value: progress.progress,
              )
            ],
          );
        },
        errorWidget: (context, url, error) {
          return Shimmer.fromColors(
            highlightColor: Colors.white24,
            baseColor: Colors.grey[400]!,
            period: const Duration(milliseconds: 800),
            child: Container(
              margin: const EdgeInsets.only(right: 0),
              color: Colors.black,
            ),
          );
          return Center(
            child: const Text("Failed"),
          );
        },
      ),
    );
  }
}
