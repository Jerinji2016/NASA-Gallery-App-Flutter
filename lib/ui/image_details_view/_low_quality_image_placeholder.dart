part of image_details_view;

class _LowQualityImagePlaceHolder extends StatelessWidget {
  final ImageData image;

  const _LowQualityImagePlaceHolder({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      backgroundDecoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      imageProvider: CachedNetworkImageProvider(
        image.url,
      ),
      errorBuilder: (_, __, ___) {
        return Material(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.wifi_off_outlined,
                    color: Colors.red,
                  ),
                ),
                Text(
                  "Failed to load Image",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
        );
      },
      loadingBuilder: (context, imageChunkEvent) {
        double? downloaded, total, progress;

        debugPrint("_LowQualityImagePlaceHolder.build: this");
        if (imageChunkEvent != null) {
          downloaded = imageChunkEvent.cumulativeBytesLoaded / 1000000;
          total = imageChunkEvent.expectedTotalBytes! / 1000000;
          progress = imageChunkEvent.cumulativeBytesLoaded / imageChunkEvent.expectedTotalBytes!;
        }

        return Material(
          child: Stack(
            children: [
              const CustomLoadingShimmer(),
              Positioned(
                bottom: 20.0,
                left: 20.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      image.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    if (total != null && downloaded != null)
                      Text(
                        "Downloading (${downloaded.toStringAsFixed(2)}/${total.toStringAsFixed(2)} MB)",
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontSize: 12.0,
                            ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
