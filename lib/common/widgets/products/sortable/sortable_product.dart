import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_store/features/shop/controllers/products/all_products_contorller.dart';
import 'package:trip_store/l10n/app_localizations.dart';

import '../../../../features/shop/models/product_model.dart';
import '../../../../utils/constants/sizes.dart';
import '../../layouts/grid_layout.dart';
import '../product_card/product_card_vertical.dart';

class TSortableProducts extends StatelessWidget {
  const TSortableProducts({super.key, required this.products});
  final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final controller = Get.put(AllProductController());
    controller.assignProduct(products);
    return Column(
      children: [
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          value: controller.selectedSortOption.value,
          items: [
            DropdownMenuItem(
              value: 'Name',
              child: Text(localizations.sortByName),
            ),
            DropdownMenuItem(
              value: 'Higher Price',
              child: Text(localizations.sortByHigherPrice),
            ),
            DropdownMenuItem(
              value: 'Lower Price',
              child: Text(localizations.sortByLowerPrice),
            ),
            DropdownMenuItem(
              value: 'Newest',
              child: Text(localizations.sortByNewest),
            ),
            DropdownMenuItem(
              value: 'Popularity',
              child: Text(localizations.sortByPopularity),
            ),
          ],
          onChanged: (value) {
            controller.sortProducts(value!);
          },
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
        Obx(
          () => TGridLayout(
            itemCount: controller.products.length,
            mainAxisExtent: 300, // Tăng chiều cao để tránh overflow
            itemBuilder: (_, index) =>
                TProductCardVertical(productModel: controller.products[index]),
          ),
        ),
      ],
    );
  }
}
