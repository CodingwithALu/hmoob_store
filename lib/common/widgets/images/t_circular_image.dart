import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trip_store/common/widgets/shimmer/shimmer.dart';
import 'package:trip_store/utils/helpers/helper_functions.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class TCircularImage extends StatelessWidget {
  const TCircularImage({
    super.key,
    this.width = 56,
    this.height = 56,
    this.padding = TSizes.sm,
    this.fit = BoxFit.cover,
    required this.image,
    this.overlayColor,
    this.backgroundColor,
    this.isNetworkImage = false,
  });
  final double width, height, padding;
  final BoxFit? fit;
  final String image;
  final Color? overlayColor;
  final Color? backgroundColor;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor ?? (dark ? TColors.black : TColors.white),
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipOval(
        child: isNetworkImage
            ? CachedNetworkImage(
                width: double.infinity,
                height: double.infinity,
                fit: fit,
                color: overlayColor,
                imageUrl: image,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    const TShimmerEffect(width: 55, height: 55),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )
            : Image(
                width: double.infinity,
                height: double.infinity,
                fit: fit,
                image: AssetImage(image),
                color: overlayColor,
              ),
      ),
    );
  }
}
