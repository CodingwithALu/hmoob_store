import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:t_store/common/widgets/texts/product_price_text.dart';
import 'package:t_store/common/widgets/texts/product_title_text.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/controllers/products/variation_controller.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

import '../../../../../../common/widgets/chips/choice_chip.dart';
import '../../../../../../utils/constants/sizes.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({super.key, required this.products});
  final ProductModel products;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(VariationController());
    return Obx(
      () => Column(
        children: [
          /// Selection Attributes
          if (controller.selectedVariation.value.id.isNotEmpty)
            TRoundedContainer(
              padding: EdgeInsets.all(TSizes.md),
              backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const TSectionHeading(
                        title: 'Variation',
                        showActionButton: false,
                      ),
                      const SizedBox(width: TSizes.spaceBtwItems),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const TProductTitleText(
                                title: 'Price : ',
                                smallSize: true,
                              ),
                              if (controller.selectedVariation.value.salePrice >
                                  0)
                                Text(
                                  '\$${controller.selectedVariation.value.price}',
                                  style: Theme.of(context).textTheme.titleSmall!
                                      .apply(
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                ),
                              if (controller.selectedVariation.value.salePrice >
                                  0)
                                const SizedBox(width: TSizes.spaceBtwItems),
                              TProductPriceText(
                                price: controller.getVariationPrice(),
                              ),
                            ],
                          ),

                          /// Stock
                          Row(
                            children: [
                              const TProductTitleText(
                                title: 'Stock : ',
                                smallSize: true,
                              ),
                              Text(
                                controller.variationStockStatus.value,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  TProductTitleText(
                    title: controller.selectedVariation.value.description ?? '',
                    smallSize: true,
                    maxLines: 4,
                  ),
                ],
              ),
            ),
          const SizedBox(height: TSizes.spaceBtwItems),

          /// Attributes
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: products.productAttributeModel!
                .map(
                  (attribute) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TSectionHeading(
                        title: attribute.name ?? '',
                        showActionButton: false,
                      ),
                      SizedBox(height: TSizes.spaceBtwItems / 2),
                      Obx(
                        () => Wrap(
                          spacing: 8,
                          children: attribute.value!.map((attributeValue) {
                            final isSelected =
                                controller.selectedAttribute[attribute.name] ==
                                attributeValue;
                            final available = controller
                                .getAttributesAvailabilityInVariation(
                                  products.productVariations!,
                                  attribute.name!,
                                )
                                .contains(attributeValue);
                            return TChoiceChip(
                              text: attributeValue,
                              selected: isSelected,
                              onSelected: available
                                  ? (selected) {
                                      if (selected && available) {
                                        controller.onAttributeSelected(
                                          products,
                                          attribute.name ?? '',
                                          attributeValue,
                                        );
                                      }
                                    }
                                  : null,
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
