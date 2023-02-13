import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:photo_view/photo_view.dart';

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

  double? _progress, _total, _downloaded;

  bool _isHdDownloaded = false;

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
                      if (imageChunkEvent != null) {
                        _downloaded = imageChunkEvent.cumulativeBytesLoaded / 1000000;
                        _total = imageChunkEvent.expectedTotalBytes! / 1000000;
                        _progress = imageChunkEvent.cumulativeBytesLoaded / imageChunkEvent.expectedTotalBytes!;

                        if (_progress == 1.0) {
                          SchedulerBinding.instance.addPostFrameCallback(
                            (_) => setState(() {
                              _isHdDownloaded = true;
                              controller.forward(from: 0.0);
                            }),
                          );
                        }
                      }

                      return PhotoView(
                        backgroundDecoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        imageProvider: CachedNetworkImageProvider(
                          widget.image.url,
                        ),
                      );
                    },
                    errorBuilder: (context, url, error) {
                      return Material(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: const Text("Failed to load Image"),
                      );
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
