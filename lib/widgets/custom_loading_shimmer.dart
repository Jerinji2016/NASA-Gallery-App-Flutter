import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../provider/data_provider.dart';

class CustomLoadingShimmer extends StatelessWidget {
  const CustomLoadingShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppDataProvider provider = AppDataProvider.of(context);
    Color baseColor = provider.isDarkTheme ? Colors.grey[900]! : Colors.grey[400]!;
    Color highlightColor = provider.isDarkTheme ? Colors.grey[800]! : Colors.grey[300]!;

    return Shimmer.fromColors(
      highlightColor: highlightColor,
      baseColor: baseColor,
      period: const Duration(milliseconds: 800),
      child: Center(
        child: Container(
          color: Colors.blue,
        ),
      ),
    );
  }
}
