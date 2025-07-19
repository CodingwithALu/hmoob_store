import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmoob_store/common/widgets/appbar/appbar.dart';
import 'package:hmoob_store/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:hmoob_store/common/widgets/images/t_rounded_image.dart';
import 'package:hmoob_store/common/widgets/products/favourite_icon.dart';
import 'package:hmoob_store/features/shop/controllers/products/images_controller.dart';
import 'package:hmoob_store/features/shop/models/product_model.dart';
import 'package:hmoob_store/utils/constants/sizes.dart';
import 'package:hmoob_store/utils/helpers/helper_functions.dart';

import '../../../../../../utils/constants/colors.dart';

class ProductDetailImageSlider extends StatelessWidget {
  const ProductDetailImageSlider({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(ImagesController());
    final images = controller.getAllProductImage(product);
    return TCurvedEdgeWidget(
      child: Container(
        color: dark ? TColors.darkerGrey : TColors.light,
        child: Stack(
          children: [
            SizedBox(
              height: 400,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: TSizes.productImageRadius * 2,
                  vertical: TSizes.productImageRadius * 3,
                ),
                child: Center(
                  child: Obx(() {
                    final image = controller.selectedProductImage.value;
                    return GestureDetector(
                      onTap: () => controller.showEnlargedImage(image),
                      child: CachedNetworkImage(
                        imageUrl: image,
                        progressIndicatorBuilder: (_, __, downloadProgress) =>
                            CircularProgressIndicator(
                              value: downloadProgress.progress,
                              color: TColors.primary,
                            ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 30,
              left: TSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: TSizes.spaceBtwItems),
                  itemCount: images.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (_, index) => Obx(() {
                    final imageSelected =
                        controller.selectedProductImage.value == images[index];
                    return TRoundedImage(
                      padding: const EdgeInsets.all(TSizes.sm),
                      width: 80,
                      onPressed: () =>
                          controller.selectedProductImage.value = images[index],
                      isNetworkImage: true,
                      backgroundColor: dark ? TColors.dark : TColors.light,
                      border: Border.all(
                        color: imageSelected
                            ? TColors.primary
                            : Colors.transparent,
                      ),
                      imageUrl: images[index],
                    );
                  }),
                ),
              ),
            ),

            /// Appbar Icons
            TAppBar(
              showBackArrow: true,
              actions: [TFavouriteIcon(productId: product.id)],
            ),
          ],
        ),
      ),
    );
  }
}
