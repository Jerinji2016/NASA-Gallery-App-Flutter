part of image_details_view;

class _ImageDetailsDelegate extends StatelessWidget {
  final ImageData image;

  const _ImageDetailsDelegate({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color iconColor = AppDataProvider.of(context).isDarkTheme ? Colors.white : Colors.black;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              image.title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16.0),
            Text(
              image.explanation,
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.date_range,
                  size: 14.0,
                  color: iconColor,
                ),
                const SizedBox(width: 8.0),
                Text(
                  image.formattedDate,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            if (image.copyright != null) ...[
              const SizedBox(height: 4.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.copyright,
                    size: 14.0,
                    color: iconColor,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    image.copyright!,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
