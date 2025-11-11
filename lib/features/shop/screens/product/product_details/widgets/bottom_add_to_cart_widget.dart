import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_store/common/widgets/icons/t_circular_icon.dart';
import 'package:trip_store/features/shop/controllers/products/cart_controller.dart';
import 'package:trip_store/features/shop/models/product_model.dart';
import 'package:trip_store/l10n/app_localizations.dart';
import 'package:trip_store/utils/constants/colors.dart';
import 'package:trip_store/utils/helpers/helper_functions.dart';

import '../../../../../../utils/constants/sizes.dart';

class TButtomAddToCart extends StatelessWidget {
  const TButtomAddToCart({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final localizations = AppLocalizations.of(context)!;
    final controller = CartController.instance;
    controller.updateAlreadyAddedProductCount(product);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: TSizes.defaultSpace,
        vertical: TSizes.defaultSpace / 2,
      ),
      decoration: BoxDecoration(
        color: dark ? TColors.darkerGrey : TColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(TSizes.cardRadiusLg),
          topRight: Radius.circular(TSizes.cardRadiusLg),
        ),
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                TCircularIcon(
                  icon: Iconsax.minus,
                  backgroundColor: TColors.darkerGrey,
                  width: 40,
                  height: 40,
                  color: TColors.white,
                  onPressed: controller.productQuantityInCart.value < 1
                      ? null
                      : () => controller.productQuantityInCart.value -= 1,
                ),
                const SizedBox(width: TSizes.spaceBtwItems),
                Text(
                  controller.productQuantityInCart.value.toString(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(width: TSizes.spaceBtwItems),
                TCircularIcon(
                  icon: Iconsax.add,
                  backgroundColor: TColors.black,
                  width: 40,
                  height: 40,
                  color: TColors.white,
                  onPressed: () => controller.productQuantityInCart.value += 1,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () => controller.productQuantityInCart.value < 1
                  ? null
                  : controller.addToCart(
                      product,
                      selectQuantityMessage: localizations.selectQuantity,
                      selectVariationMessage: localizations.selectVariation,
                      outOfStockVariationMessage:
                          localizations.outOfStockVariation,
                      outOfStockProductMessage: localizations.outOfStockProduct,
                      productAddedMessage: localizations.productAddedToCart,
                      errorTitle: localizations.bannerErrorTitle,
                    ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(TSizes.md),
                backgroundColor: TColors.black,
                side: const BorderSide(color: TColors.black),
              ),
              child: Text(localizations.addToCartButton),
            ),
          ],
        ),
      ),
    );
  }
}
