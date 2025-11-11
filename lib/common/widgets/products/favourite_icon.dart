import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_store/common/widgets/icons/t_circular_icon.dart';
import 'package:trip_store/features/shop/controllers/favourite_controller.dart';
import 'package:trip_store/l10n/app_localizations.dart';
import 'package:trip_store/utils/constants/colors.dart';

class TFavouriteIcon extends StatelessWidget {
  const TFavouriteIcon({super.key, required this.productId});
  final String productId;
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final controller = Get.put(FavouritesController());
    return Obx(
      () => TCircularIcon(
        icon: controller.isFavourite(productId)
            ? Iconsax.heart5
            : Iconsax.heart,
        color: controller.isFavourite(productId) ? TColors.error : null,
        onPressed: () => controller.toggleFavoriteProduct(
          productId,
          addedMessage: localizations.productAddedToWishlist,
          removedMessage: localizations.productRemovedFromWishlist,
        ),
      ),
    );
  }
}
