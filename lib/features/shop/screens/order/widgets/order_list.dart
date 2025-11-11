import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_store/features/shop/controllers/products/order_controller.dart';
import 'package:trip_store/l10n/app_localizations.dart';
import 'package:trip_store/navigation_menu.dart';
import 'package:trip_store/utils/constants/image_strings.dart';
import 'package:trip_store/utils/helpers/cloud_helper_functions.dart';
import 'package:trip_store/utils/loaders/animation_loader.dart';

import '../../../../../common/widgets/custom_shapes/container/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class TOrderListItems extends StatelessWidget {
  const TOrderListItems({super.key});
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(OrderController());
    return FutureBuilder(
      future: controller.fetchUserOrders(),
      builder: (_, snapshot) {
        /// Nothing Found Widget
        final emptyWidget = TAnimationLoaderWidget(
          text: localizations.noOrdersYet,
          animation: TImages.orderCompletedAnimation,
          showAction: true,
          actionText: localizations.orderFillIt,
          onActionPressed: () => Get.off(() => const NavigationMenu()),
        ); // TAnimationLoaderWidget

        /// Helper Function: Handle Loader, No Record, OR ERROR Message
        final response = TCloudHelperFunctions.checkMultiRecordState(
          snapshot: snapshot,
          nothingFound: emptyWidget,
        );
        if (response != null) return response;

        /// Congratulations 🎉 Record found.
        final orders = snapshot.data!;
        return ListView.separated(
          shrinkWrap: true,
          itemCount: orders.length,
          separatorBuilder: (_, __) =>
              const SizedBox(height: TSizes.spaceBtwItems),
          itemBuilder: (_, index) {
            final order = orders[index];
            return TRoundedContainer(
              showBorder: true,
              padding: EdgeInsets.all(TSizes.md),
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: Column(
                children: [
                  Row(
                    children: [
                      /// Icon
                      Icon(Iconsax.ship),
                      SizedBox(width: TSizes.spaceBtwItems / 2),

                      /// Status and Dates]
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.orderStatusText,
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .apply(
                                    color: TColors.primary,
                                    fontWeightDelta: 1,
                                  ),
                            ),
                            Text(
                              order.formattedOrderDate,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ],
                        ),
                      ),

                      /// Icon Button
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Iconsax.arrow_right_34,
                          size: TSizes.iconSm,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// Row 2
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            /// Icon
                            Icon(Iconsax.tag),
                            SizedBox(width: TSizes.spaceBtwItems / 2),

                            /// Status and Dates]
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    localizations.order,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .apply(
                                          color: TColors.primary,
                                          fontWeightDelta: 1,
                                        ),
                                  ),
                                  Text(
                                    order.id,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            /// Icon
                            Icon(Iconsax.calendar),
                            SizedBox(width: TSizes.spaceBtwItems / 2),

                            /// Status and Dates
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    localizations.shippingDate,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .apply(
                                          color: TColors.primary,
                                          fontWeightDelta: 1,
                                        ),
                                  ),
                                  Text(
                                    order.formattedDeliveryDate,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
