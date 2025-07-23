import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_store/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:trip_store/features/shop/screens/product/all_products/all_products.dart';
import 'package:trip_store/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:trip_store/features/shop/screens/home/widgets/home_categories.dart';
import 'package:trip_store/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:trip_store/l10n/app_localizations.dart';
import 'package:trip_store/utils/constants/colors.dart';
import 'package:trip_store/utils/constants/sizes.dart';
import '../../../../common/widgets/custom_shapes/container/primary_header_container.dart';
import '../../../../common/widgets/custom_shapes/container/search_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/product_card/product_card_vertical.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../controllers/products/product_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    final local = AppLocalizations.of(context)!;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  /// Appbar
                  const THomeAppBar(),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// Searchbar
                  TSearchContainer(text: local.searchInStore),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// Categories
                  Padding(
                    padding: const EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        TSectionHeading(
                          title: local.popularCategories,
                          showActionButton: false,
                          textColor: TColors.white,
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems),
                        THomeCategories(),
                      ],
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections * 1.5),
                ],
              ),
            ),

            /// Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  /// Promo Slider
                  TPromoSlider(),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  ///Heading
                  TSectionHeading(
                    title: local.popularProducts,
                    onPressed: () => Get.to(
                      () => AllProducts(
                        title: local.popularProduct,
                        query: FirebaseFirestore.instance
                            .collection('Products')
                            .where('IsFeatured', isEqualTo: true)
                            .limit(6),
                        futureMethod: controller.fetchAllFeaturedProducts(),
                      ),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  ///popular Products
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const TVerticalProductShimmer();
                    }
                    if (controller.featureProducts.isEmpty) {
                      return Center(
                        child: Text(
                          local.noDataFound,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    }
                    return TGridLayout(
                      itemCount: controller.featureProducts.length,
                      itemBuilder: (_, index) => TProductCardVertical(
                        productModel: controller.featureProducts[index],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
