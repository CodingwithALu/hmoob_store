import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmoob_store/common/widgets/shimmer/shimmer.dart';
import 'package:hmoob_store/l10n/app_localizations.dart';
import '../../../../../common/widgets/custom_shapes/container/circular_container.dart';
import '../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/banners/banner_controller.dart';

class TPromoSlider extends StatelessWidget {
  const TPromoSlider({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    final local = AppLocalizations.of(context)!;
    return Obx(() {
      // Loader
      if (controller.isLoading.value) {
        return const TShimmerEffect(width: double.infinity, height: 1900);
      }
      if (controller.banners.isEmpty) {
        return Center(child: Text(local.noDataFound));
      } else {
        return Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 1,
                onPageChanged: (index, _) =>
                    controller.updatePageIndicator(index),
              ),
              items: controller.banners
                  .map(
                    (banner) => TRoundedImage(
                      imageUrl: banner.imageUrl,
                      isNetworkImage: true,
                      onPressed: () => Get.toNamed(banner.targetScreen),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Center(
              child: Obx(
                () => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int i = 0; i < controller.banners.length; i++)
                      TCircularContainer(
                        width: 20,
                        height: 4,
                        backgroundColor:
                            controller.carousalCurrentIndex.value == i
                            ? TColors.primary
                            : Colors.green,
                        margin: EdgeInsets.only(right: 10),
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      }
    });
  }
}
