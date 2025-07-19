import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmoob_store/common/widgets/appbar/appbar.dart';
import 'package:hmoob_store/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:hmoob_store/features/shop/controllers/products/cart_controller.dart';
import 'package:hmoob_store/features/shop/controllers/products/order_controller.dart';
import 'package:hmoob_store/features/shop/screens/cart/widgets/cart_item_list.dart';
import 'package:hmoob_store/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:hmoob_store/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:hmoob_store/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:hmoob_store/utils/constants/colors.dart';
import 'package:hmoob_store/utils/helpers/helper_functions.dart';
import 'package:hmoob_store/utils/helpers/pricing_calculator.dart';
import 'package:hmoob_store/utils/popups/loaders.dart';

import '../../../../common/widgets/products/cart/coupon_widget.dart';
import '../../../../utils/constants/sizes.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    // implement build
    final controller = CartController.instance;
    final subTotal = controller.totalCartPrice.value;
    final orderController = Get.put(OrderController());
    final totalAmout = TPricingCalculator.calculateTotalPrice(subTotal, 'Us');
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Order Review',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Items in cart
              TCartItemList(showAddRemoveButtons: false),
              SizedBox(height: TSizes.spaceBtwSections),

              /// Coupon TextField
              TCouponCode(),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Billing Section
              TRoundedContainer(
                showBorder: true,
                padding: EdgeInsets.all(TSizes.md),
                backgroundColor: dark ? TColors.black : TColors.white,
                child: Column(
                  children: [
                    /// Pricing
                    TBillingAmountSection(),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    /// Divider
                    const Divider(),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    /// Payment Methods
                    TBillingPaymentSection(),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    /// Address
                    TBillingAddressSection(),
                    const SizedBox(height: TSizes.spaceBtwItems),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      ///Checkout Button
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: subTotal > 0
              ? () => orderController.processOrder(totalAmout)
              : () => TLoaders.warningSnackBar(
                  title: 'Empty Cart',
                  message: 'Add items in the cart order to proseed',
                ),
          child: Text(
            'Checkout \$${TPricingCalculator.calculateTotalPrice(subTotal, 'US')}',
          ),
        ),
      ),
    );
  }
}
