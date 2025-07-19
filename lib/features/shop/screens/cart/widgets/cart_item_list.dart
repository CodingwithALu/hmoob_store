import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hmoob_store/features/shop/controllers/products/cart_controller.dart';

import '../../../../../common/widgets/products/cart/add_remove_button.dart';
import '../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../utils/constants/sizes.dart';

class TCartItemList extends StatelessWidget {
  const TCartItemList({super.key, this.showAddRemoveButtons = true});
  final bool showAddRemoveButtons;
  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (_, __) =>
          const SizedBox(height: TSizes.spaceBtwSections),
      itemCount: controller.cartItems.length,
      itemBuilder: (_, index) => Obx(() {
        final item = controller.cartItems[index];
        return Column(
          children: [
            /// Item Cart
            TCartItem(cartItem: item),
            if (showAddRemoveButtons) SizedBox(height: TSizes.spaceBtwItems),

            /// Quantity 7 Price
            if (showAddRemoveButtons)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 70),

                      /// Add Remove Button
                      TProductQuantityWithAddRemoveButton(
                        quantity: item.quantity,
                        add: () => controller.addOneToCart(item),
                        remove: () => controller.removeOneFromCart(item),
                      ),
                    ],
                  ),

                  /// Price
                  TProductPriceText(
                    price: (item.price * item.quantity).toStringAsFixed(1),
                  ),
                ],
              ),
          ],
        );
      }),
    );
  }
}
