import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_store/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:trip_store/common/widgets/texts/product_price_text.dart';
import 'package:trip_store/common/widgets/texts/product_title_text.dart';
import 'package:trip_store/common/widgets/texts/section_heading.dart';
import 'package:trip_store/features/shop/controllers/products/variation_controller.dart';
import 'package:trip_store/features/shop/models/product_model.dart';
import 'package:trip_store/l10n/app_localizations.dart';
import 'package:trip_store/utils/constants/colors.dart';
import 'package:trip_store/utils/helpers/helper_functions.dart';

import '../../../../../../common/widgets/chips/choice_chip.dart';
import '../../../../../../utils/constants/sizes.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({super.key, required this.products});
  final ProductModel products;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(VariationController());
    final localizations = AppLocalizations.of(context)!;
    return Obx(
      () => Column(
        children: [
          // Selection Attributes
          if (controller.selectedVariation.value.id.isNotEmpty)
            TRoundedContainer(
              padding: EdgeInsets.all(TSizes.md),
              backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      TSectionHeading(
                        title: localizations.variationSection,
                        showActionButton: false,
                      ),
                      const SizedBox(width: TSizes.spaceBtwItems),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              TProductTitleText(
                                title: localizations.priceLabel,
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
                          // Stock
                          Row(
                            children: [
                              TProductTitleText(
                                title: localizations.stockLabel,
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
          // Attributes
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: products.productAttributeModel!
                .map(
                  (attribute) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TSectionHeading(
                        title:
                            attribute.name ?? localizations.attributesSection,
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
