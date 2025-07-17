import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/features/shop/screens/product/product_details/widgets/bottom_add_to_cart_widget.dart';
import 'package:t_store/features/shop/screens/product/product_details/widgets/product_attributes.dart';
import 'package:t_store/features/shop/screens/product/product_details/widgets/product_detail_image_slider.dart';
import 'package:t_store/features/shop/screens/product/product_details/widgets/product_meta_data.dart';
import 'package:t_store/features/shop/screens/product/product_details/widgets/rating_share_widgets.dart';
import 'package:t_store/features/shop/screens/product/product_review/prooduct_review.dart';
import 'package:t_store/utils/constants/enums.dart';

import '../../../../../utils/constants/sizes.dart';
import 'package:t_store/l10n/app_localizations.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.products});
  final ProductModel products;
  @override
  Widget build(BuildContext context) {
    // implement build
    return Scaffold(
      bottomNavigationBar: TButtonAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 1 Product Images Slider
            ProductDetailImageSlider(product: products),

            /// 2 Product Details
            Padding(
              padding: EdgeInsets.only(
                right: TSizes.defaultSpace,
                left: TSizes.defaultSpace,
                bottom: TSizes.defaultSpace,
              ),
              child: Column(
                children: [
                  /// - Rating & Share
                  TRatingAndShare(),

                  /// - Price, Title, Stock, & Brand
                  TProductMetaData(products: products),

                  /// - Attributes
                  if (products.productType == ProductType.variable.toString())
                    TProductAttributes(products: products),
                  if (products.productType == ProductType.variable.toString())
                    const SizedBox(height: TSizes.spaceBtwSections),

                  /// - Checkout Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(AppLocalizations.of(context)!.checkoutButton),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// - Description
                  TSectionHeading(
                    title: AppLocalizations.of(context)!.descriptionSection,
                    showActionButton: false,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  ReadMoreText(
                    textAlign: TextAlign.start,
                    products.description ?? '',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: AppLocalizations.of(context)!.showMore,
                    trimExpandedText: AppLocalizations.of(context)!.showLess,
                    moreStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                    lessStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  /// - Review
                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TSectionHeading(
                        title:
                            '${AppLocalizations.of(context)!.reviewSection}(199)',
                        showActionButton: false,
                      ),
                      IconButton(
                        icon: const Icon(Iconsax.arrow_right_3, size: 18),
                        onPressed: () =>
                            Get.to(() => const ProductReviewScreen()),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
