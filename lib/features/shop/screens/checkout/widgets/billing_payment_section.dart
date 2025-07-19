import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmoob_store/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:hmoob_store/common/widgets/texts/section_heading.dart';
import 'package:hmoob_store/features/shop/controllers/checkouts/checkout_controller.dart';
import 'package:hmoob_store/utils/constants/colors.dart';
import 'package:hmoob_store/utils/helpers/helper_functions.dart';

import '../../../../../utils/constants/sizes.dart';

class TBillingPaymentSection extends StatelessWidget {
  const TBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    // implement build
    final controller = Get.put(CheckoutController());
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        TSectionHeading(
          title: 'Payment Method',
          buttonTitle: "Change",
          onPressed: () => controller.selectPaymentMethod(context),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        Obx(
          () => Row(
            children: [
              TRoundedContainer(
                width: 60,
                height: 35,
                backgroundColor: dark ? TColors.light : TColors.white,
                padding: EdgeInsets.all(TSizes.sm),
                child: Image(
                  image: AssetImage(
                    controller.selectecPaymentMethod.value.image,
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              Text(
                controller.selectecPaymentMethod.value.name,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
