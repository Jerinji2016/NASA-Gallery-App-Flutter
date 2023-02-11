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
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: widget.image.key,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: PhotoView(
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
                  controller.forward();
                }
              }

              return Material(
                color: Colors.transparent,
                child: Center(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Positioned(
                        bottom: 20.0,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Text("jerin"),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4.0),
                                  ),
                                  child: LinearProgressIndicator(
                                    value: progress,
                                    color: Colors.orange,
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Shimmer.fromColors(
                        highlightColor: Colors.white,
                        baseColor: Colors.grey[500]!,
                        period: const Duration(milliseconds: 800),
                        child: Container(
                          margin: const EdgeInsets.only(right: 0),
                          height: 350,
                          width: 270,
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(16),
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
    );
  }
}
