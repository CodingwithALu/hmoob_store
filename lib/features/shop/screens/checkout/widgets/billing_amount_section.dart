import 'package:flutter/material.dart';
import 'package:trip_store/features/shop/controllers/products/cart_controller.dart';
import 'package:trip_store/l10n/app_localizations.dart';
import 'package:trip_store/utils/helpers/pricing_calculator.dart';

import '../../../../../utils/constants/sizes.dart';

class TBillingAmountSection extends StatelessWidget {
  const TBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    // implement build
    final controller = CartController.instance;
    final subTotal = controller.totalCartPrice.value;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              localizations.subtotal,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text('\$$subTotal', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        /// Shipping Free
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              localizations.shippingFee,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              '\$${TPricingCalculator.calculateShippingCost(subTotal, 'US')}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        /// Tax fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              localizations.taxFee,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              '\$${TPricingCalculator.calculateTax(subTotal, 'US')}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        /// Order total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              localizations.orderTotal,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              '\$${TPricingCalculator.calculateTotalPrice(subTotal, 'US')}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }
}
