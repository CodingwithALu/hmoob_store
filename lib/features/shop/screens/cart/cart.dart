import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_store/common/widgets/appbar/appbar.dart';
import 'package:trip_store/features/shop/controllers/products/cart_controller.dart';
import 'package:trip_store/features/shop/screens/cart/widgets/cart_item_list.dart';
import 'package:trip_store/features/shop/screens/checkout/checkout.dart';
import 'package:trip_store/navigation_menu.dart';
import 'package:trip_store/utils/constants/image_strings.dart';
import 'package:trip_store/utils/loaders/animation_loader.dart';
import 'package:trip_store/l10n/app_localizations.dart';
import '../../../../utils/constants/sizes.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    // implement build
    final controller = CartController.instance;
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          localizations.cart,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),
      body: Obx(() {
        // Nothing Foud Widget
        final emptyWodget = TAnimationLoaderWidget(
          text: localizations.cartEmpty,
          animation: TImages.cartAnimation,
          showAction: true,
          actionText: localizations.cartFillIt,
          onActionPressed: () => Get.off(() => const NavigationMenu()),
        );

        return controller.cartItems.isEmpty
            ? emptyWodget
            : Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: TCartItemList(),
              );
      }),

      /// Checkout Button
      bottomNavigationBar: controller.cartItems.isEmpty
          ? const SizedBox()
          : Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: ElevatedButton(
                onPressed: () => Get.to(() => CheckoutScreen()),
                child: Obx(
                  () => Text(
                    '${localizations.checkout} \$${controller.totalCartPrice.value}',
                  ),
                ),
              ),
            ),
    );
  }
}
