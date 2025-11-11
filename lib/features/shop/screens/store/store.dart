import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_store/common/widgets/appbar/appbar.dart';
import 'package:trip_store/common/widgets/custom_shapes/container/search_container.dart';
import 'package:trip_store/common/widgets/layouts/grid_layout.dart';
import 'package:trip_store/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:trip_store/common/widgets/shimmer/brand_shimmer.dart';
import 'package:trip_store/common/widgets/texts/section_heading.dart';
import 'package:trip_store/features/shop/controllers/brands/brands_contorller.dart';
import 'package:trip_store/features/shop/controllers/categories/category_controller.dart';
import 'package:trip_store/features/shop/screens/brands/all_brands.dart';
import 'package:trip_store/features/shop/screens/brands/brand_products.dart';
import 'package:trip_store/features/shop/screens/cart/cart.dart';
import 'package:trip_store/features/shop/screens/store/widgets/t_category_tab.dart';
import 'package:trip_store/l10n/app_localizations.dart';
import 'package:trip_store/utils/constants/colors.dart';
import 'package:trip_store/utils/helpers/helper_functions.dart';
import '../../../../common/widgets/appbar/t_tab_bar.dart';
import '../../../../common/widgets/brands/t_brand_card.dart';
import '../../../../utils/constants/sizes.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final categories = CategoryController.instance.featureCategories;
    final controller = Get.put(BrandsContorller());
    final dark = THelperFunctions.isDarkMode(context);
    final local = AppLocalizations.of(context)!;
    // implement build
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: TAppBar(
          title: Text(
            local.store,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            TCartCounterIcon(onPressed: () => Get.to(() => CartScreen())),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: dark ? TColors.black : TColors.white,
                expandedHeight: 440,
                flexibleSpace: Padding(
                  padding: EdgeInsets.all(TSizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      /// Search bar
                      SizedBox(height: TSizes.spaceBtwItems),
                      TSearchContainer(
                        text: local.searchInStore,
                        showBorder: true,
                        showBackground: false,
                        padding: EdgeInsets.zero,
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      /// Featured Brands
                      TSectionHeading(
                        title: local.featuredBrands,
                        onPressed: () => Get.to(() => BrandScreen()),
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems / 1.5),

                      Obx(() {
                        if (controller.isLoading.value) return TBrandsShimmer();
                        if (controller.featureBrands.isEmpty) {
                          return Center(
                            child: Text(
                              local.noDataFound,
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .apply(color: Colors.white),
                            ),
                          );
                        }
                        return TGridLayout(
                          itemCount: controller.featureBrands.length,
                          mainAxisExtent: 80,
                          itemBuilder: (_, index) {
                            final brand = controller.featureBrands[index];
                            return TBrandCard(
                              showBorder: false,
                              brands: brand,
                              onTap: () =>
                                  Get.to(() => BrandProducts(brands: brand)),
                            );
                          },
                        );
                      }),
                    ],
                  ),
                ),
                bottom: TTabBar(
                  tabs: categories
                      .map((category) => Tab(child: Text(category.name)))
                      .toList(),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: categories
                .map((category) => TCategoryTab(categoryModel: category))
                .toList(),
          ),
        ),
      ),
    );
  }
}
