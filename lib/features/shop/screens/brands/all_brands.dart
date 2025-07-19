import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmoob_store/common/widgets/appbar/appbar.dart';
import 'package:hmoob_store/common/widgets/brands/t_brand_card.dart';
import 'package:hmoob_store/common/widgets/layouts/grid_layout.dart';
import 'package:hmoob_store/common/widgets/shimmer/brand_shimmer.dart';
import 'package:hmoob_store/features/shop/controllers/brands/brands_contorller.dart';
import 'package:hmoob_store/features/shop/screens/brands/brand_products.dart';

import '../../../../utils/constants/sizes.dart';

class BrandScreen extends StatelessWidget {
  const BrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // implement build
    final controller = BrandsContorller.instance;
    return Scaffold(
      appBar: TAppBar(title: Text('Brand'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Brands
              Obx(() {
                if (controller.isLoading.value) return TBrandsShimmer();
                if (controller.allBrands.isEmpty) {
                  return Center(
                    child: Text(
                      'No Data Foud!',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.apply(color: Colors.white),
                    ),
                  );
                }
                return TGridLayout(
                  itemCount: controller.allBrands.length,
                  mainAxisExtent: 80,
                  itemBuilder: (_, index) {
                    final brand = controller.allBrands[index];
                    return TBrandCard(
                      showBorder: false,
                      brands: brand,
                      onTap: () => Get.to(() => BrandProducts(brands: brand)),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
