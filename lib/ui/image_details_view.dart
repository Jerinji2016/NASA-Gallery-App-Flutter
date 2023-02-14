import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shimmer/shimmer.dart';

import '../modals/image_data.dart';

class ImageDetailsView extends StatefulWidget {
  final ImageData image;

  const ImageDetailsView({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  State<ImageDetailsView> createState() => _ImageDetailsViewState();
}

class _ImageDetailsViewState extends State<ImageDetailsView> with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    controller.value = 1.0;
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Hero(
            tag: widget.image.key,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: AnimatedBuilder(
                animation: controller,
                builder: (context, child) => Opacity(
                  opacity: Tween<double>(begin: 0.0, end: 1.0)
                      .animate(
                        CurvedAnimation(
                          parent: controller,
                          curve: Curves.ease,
                        ),
                      )
                      .value,
                  child: PhotoView(
                    backgroundDecoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                    imageProvider: NetworkImage(
                      widget.image.hdUrl,
                    ),
                    loadingBuilder: (context, imageChunkEvent) {
                      debugPrint("ImageDetailsView.build: $imageChunkEvent");

                      double? progress, downloaded, total;
                      String? progressText;

                      if (imageChunkEvent != null) {
                        downloaded = imageChunkEvent.cumulativeBytesLoaded / 1000000;
                        total = imageChunkEvent.expectedTotalBytes! / 1000000;

                        progress = imageChunkEvent.cumulativeBytesLoaded / imageChunkEvent.expectedTotalBytes!;
                        debugPrint("ImageDetailsView.build: progress: $progress");

                        progressText = "(${downloaded.toStringAsFixed(2)}/${total.toStringAsFixed(2)} MB)";

                        if (progress == 1.0) {
                          SchedulerBinding.instance.addPostFrameCallback(
                            (_) => controller.forward(from: 0.0),
                          );
                        }
                      }

                      return Material(
                        color: Colors.transparent,
                        child: Center(
                          child: Stack(
                            children: [
                              ImageFiltered(
                                imageFilter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                                child: CachedNetworkImage(
                                  imageUrl: widget.image.url,
                                  fit: BoxFit.cover,
                                  height: MediaQuery.of(context).size.height,
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
                              Shimmer.fromColors(
                                highlightColor: Colors.white24,
                                baseColor: Colors.transparent,
                                period: const Duration(milliseconds: 800),
                                child: Container(
                                  margin: const EdgeInsets.only(right: 0),
                                  color: Colors.black,
                                ),
                              ),
                              Positioned(
                                bottom: 30.0,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    children: [
                                      Text(
                                        "${widget.image.title}${progressText != null ? " $progressText" : ""}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(4.0),
                                          ),
                                          child: LinearProgressIndicator(
                                            value: progress,
                                            minHeight: 6.0,
                                            color: Colors.orange,
                                            backgroundColor: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, url, error) {
                      return const Text("Failed to load Image");
                    },
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 10.0,
            left: 10.0,
            child: Material(
              borderRadius: const BorderRadius.all(Radius.circular(40.0)),
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                onTap: () => Navigator.pop(context),
                splashColor: Colors.white12,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Colors.grey[200]!,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
