import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:t_store/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:t_store/features/shop/controllers/categories/category_controller.dart';
import 'package:t_store/features/shop/models/category_model.dart';
import 'package:t_store/features/shop/screens/product/all_products/all_products.dart';
import 'package:t_store/features/shop/screens/store/widgets/category_brand.dart';
import 'package:t_store/l10n/app_localizations.dart';
import 'package:t_store/utils/helpers/cloud_helper_functions.dart';

import '../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../common/widgets/products/product_card/product_card_vertical.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/sizes.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key, required this.categoryModel});
  final CategoryModel categoryModel;
  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    final local = AppLocalizations.of(context)!;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              CategoryBrands(category: categoryModel),
              const SizedBox(height: TSizes.spaceBtwItems),
              FutureBuilder(
                future: controller.getCategoryProducts(
                  categoryId: categoryModel.id,
                ),
                builder: (context, snapshot) {
                  final reponse = TCloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot,
                    loader: const TVerticalProductShimmer(),
                  );
                  if (reponse != null) return reponse;
                  // Record Foud!
                  final products = snapshot.data!;
                  return Column(
                    children: [
                      TSectionHeading(
                        title: local.youMightLike,
                        showActionButton: true,
                        onPressed: () => Get.to(
                          AllProducts(
                            title: categoryModel.name,
                            futureMethod: controller.getCategoryProducts(
                              categoryId: categoryModel.id,
                              limit: -1,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      TGridLayout(
                        itemCount: products.length,
                        itemBuilder: (_, index) =>
                            TProductCardVertical(productModel: products[index]),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
