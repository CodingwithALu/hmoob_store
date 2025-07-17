import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/icons/t_circular_icon.dart';
import 'package:t_store/common/widgets/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:t_store/features/shop/controllers/favourite_controller.dart';
import 'package:t_store/features/shop/screens/home/home.dart';
import 'package:t_store/l10n/app_localizations.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/helpers/cloud_helper_functions.dart';
import 'package:t_store/utils/loaders/animation_loader.dart';

import '../../../../common/widgets/products/product_card/product_card_vertical.dart';
import '../../../../utils/constants/sizes.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // implement build
    final controller = FavouritesController.instance;
    final local = AppLocalizations.of(context)!;
    return Scaffold(
      /// AppBar
      appBar: TAppBar(
        title: Text(
          local.wishlist,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          TCircularIcon(
            icon: Iconsax.add,
            onPressed: () => Get.to(const HomeScreen()),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),

          /// Products Grid
          child: Obx(
            () => FutureBuilder(
              future: controller.favoriteProducts(),
              builder: (context, snapshot) {
                /// Nothing Found Widget
                final emptyWidget = TAnimationLoaderWidget(
                  text: local.wishlistEmpty,
                  animation: TImages.pencilAnimation,
                  showAction: true,
                  actionText: local.wishlistAddSome,
                  onActionPressed: () => {},
                );

                const loader = TVerticalProductShimmer(itemCount: 6);
                final widget = TCloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot,
                  loader: loader,
                  nothingFound: emptyWidget,
                );
                if (widget != null) return widget;

                final products = snapshot.data!;
                return TGridLayout(
                  itemCount: products.length,
                  itemBuilder: (_, index) =>
                      TProductCardVertical(productModel: products[index]),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
