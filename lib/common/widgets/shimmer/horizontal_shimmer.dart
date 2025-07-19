import 'package:flutter/material.dart';
import 'package:hmoob_store/common/widgets/shimmer/shimmer.dart';

class THorizontalProductShimmer extends StatelessWidget {
  const THorizontalProductShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0), // TSizes.spaceBtwSections
      height: 120,
      child: ListView.separated(
        itemCount: itemCount,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(
          width: 16.0, // TSizes.spaceBtwItems
        ),
        itemBuilder: (_, __) => const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image shimmer
            TShimmerEffect(width: 120, height: 120),
            SizedBox(width: 16.0), // TSizes.spaceBtwItems
            // Text shimmer
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TShimmerEffect(width: 160, height: 15),
                SizedBox(height: 8.0), // TSizes.spaceBtwItems / 2
                TShimmerEffect(width: 110, height: 15),
                SizedBox(height: 8.0), // TSizes.spaceBtwItems / 2
                TShimmerEffect(width: 80, height: 15),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
