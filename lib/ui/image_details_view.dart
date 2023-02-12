import 'package:flutter/material.dart';
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
      body: Hero(
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

                  double? progress;
                  if (imageChunkEvent != null) {
                    progress = imageChunkEvent.cumulativeBytesLoaded / imageChunkEvent.expectedTotalBytes!;
                    debugPrint("ImageDetailsView.build: progress: $progress");

                    if (progress == 1.0) {
                      controller.forward(from: 0.0);
                    }
                  }

                  return Material(
                    color: Colors.transparent,
                    child: Center(
                      child: Stack(
                        children: [
                          Shimmer.fromColors(
                            highlightColor: Colors.white38,
                            baseColor: const Color(0xFF363636),
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
                                    widget.image.title,
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
    );
  }
}
