import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmoob_store/common/widgets/shimmer/shimmer.dart';
import 'package:hmoob_store/features/personalization/controllers/user_controller.dart';
import 'package:hmoob_store/features/shop/controllers/products/cart_controller.dart';
import 'package:hmoob_store/features/shop/screens/cart/cart.dart';
import 'package:hmoob_store/l10n/app_localizations.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../../../utils/constants/colors.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    Get.put(CartController());
    final local = AppLocalizations.of(context)!;
    return TAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            local.homeAppbarTitle,
            style: Theme.of(
              context,
            ).textTheme.labelMedium!.apply(color: TColors.grey),
          ),
          Obx(() {
            if (controller.profileLoading.value) {
              return const TShimmerEffect(width: 80, height: 15);
            } else {
              return Text(
                controller.user.value.fullName,
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium!.apply(color: TColors.white),
              );
            }
          }),
        ],
      ),
      actions: [
        TCartCounterIcon(
          onPressed: () => Get.to(() => CartScreen()),
          iconColor: TColors.white,
        ),
      ],
    );
  }
}
