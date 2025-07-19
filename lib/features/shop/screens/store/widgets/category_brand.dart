import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hmoob_store/common/widgets/brands/brand_show_case.dart';
import 'package:hmoob_store/common/widgets/shimmer/boxes_shimmer.dart';
import 'package:hmoob_store/common/widgets/shimmer/list_title_shimmer.dart';
import 'package:hmoob_store/features/shop/controllers/brands/brands_contorller.dart';
import 'package:hmoob_store/features/shop/models/category_model.dart';
import 'package:hmoob_store/utils/constants/sizes.dart';
import 'package:hmoob_store/utils/helpers/cloud_helper_functions.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BrandsContorller.instance;
    return FutureBuilder(
      future: controller.getBrandforCategory(category.id),
      builder: (context, snapshot) {
        // hander loader, No record, error massege
        const loader = Column(
          children: [
            TListTileShimmer(),
            SizedBox(height: TSizes.spaceBtwItems),
            TBoxesShimmer(),
            SizedBox(height: TSizes.spaceBtwItems),
          ],
        );
        final widget = TCloudHelperFunctions.checkMultiRecordState(
          snapshot: snapshot,
          loader: loader,
        );
        if (widget != null) return widget;
        final brands = snapshot.data!;
        if (kDebugMode) {
          print(brands.length);
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: brands.length,
          itemBuilder: (_, index) {
            final brand = brands[index];
            return FutureBuilder(
              future: controller.getBrandProducts(brand.id),
              builder: (context, snapshots) {
                final widgets = TCloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshots,
                  loader: loader,
                );
                if (widgets != null) return widgets;
                final productss = snapshots.data!;
                return TBrandShowcase(
                  images: productss.map((item) => item.thumbnail).toList(),
                  brands: brand,
                );
              },
            );
          },
        );
      },
    );
  }
}
