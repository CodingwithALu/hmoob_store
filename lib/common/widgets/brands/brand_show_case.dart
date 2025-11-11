import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:trip_store/common/widgets/brands/t_brand_card.dart';
import 'package:trip_store/common/widgets/shimmer/shimmer.dart';
import 'package:trip_store/features/shop/models/brand_model.dart';
import 'package:trip_store/features/shop/screens/brands/brand_products.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../custom_shapes/container/rounded_container.dart';

class TBrandShowcase extends StatelessWidget {
  const TBrandShowcase({super.key, required this.images, required this.brands});
  final List<String> images;
  final BrandModel brands;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return InkWell(
      onTap: () => Get.to(() => BrandProducts(brands: brands)),
      child: TRoundedContainer(
        showBorder: true,
        borderColor: TColors.darkerGrey,
        backgroundColor: dark ? Colors.transparent : TColors.lightGrey,
        padding: const EdgeInsets.all(TSizes.md),
        margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
        child: Column(
          children: [
            /// Brand with Products Count
            TBrandCard(showBorder: false, brands: brands),
            const SizedBox(height: TSizes.spaceBtwItems),

            /// Brand Top 3 Products Image
            Row(
              children: images
                  .map((image) => brandTopProductImageWidget(image, context))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget brandTopProductImageWidget(String image, context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Expanded(
      child: TRoundedContainer(
        height: 100,
        padding: const EdgeInsets.all(TSizes.md),
        margin: const EdgeInsets.only(right: TSizes.sm),
        backgroundColor: dark ? TColors.darkerGrey : TColors.light,
        child: CachedNetworkImage(
          fit: BoxFit.contain,
          imageUrl: image,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              const TShimmerEffect(width: 100, height: 100),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
