import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:t_store/common/widgets/images/t_circular_image.dart';
import 'package:t_store/common/widgets/texts/product_title_text.dart';
import 'package:t_store/common/widgets/texts/t_brand_title_with_verified_icon.dart';
import 'package:t_store/features/shop/controllers/products/product_controller.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class TProductMetaData extends StatelessWidget {
  const TProductMetaData({super.key, required this.products});
  final ProductModel products;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = ProductController.instance;
    final salePercentage = controller.calculatePercentage(products.price, products.salePrices);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Price & Sale Price
        Row(
          children: [
            /// sale Tag
            TRoundedContainer(
              radius: TSizes.sm,
              backgroundColor: TColors.secondary.withAlpha((0.8 * 255).round()),
              padding: const EdgeInsets.symmetric(horizontal: TSizes.sm, vertical: TSizes.xs),
              child: Text('$salePercentage%', style: Theme.of(context,).textTheme.labelLarge!.apply(color: TColors.black),),
            ),
            const SizedBox(width: TSizes.spaceBtwItems),

            /// Price
            if(products.productType == ProductType.single.toString() && products.salePrices > 0)
            Text('\$${products.price}',
              style: Theme.of(context).textTheme.titleMedium!.apply(
                decoration: TextDecoration.lineThrough,
              ),
            ),
            if(products.productType == ProductType.single.toString() && products.salePrices > 0) const SizedBox(width: TSizes.spaceBtwItems),
            TProductPriceText(price: controller.getProductPrice(products), isLarge: true,),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5,),
        /// Title
        TProductTitleText(title: products.title),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5,),
        /// Stock Status
        Row(
          children: [
            const TProductTitleText(title: 'status'),
            const SizedBox(width: TSizes.spaceBtwItems,),
            Text(controller.getProductStockStatus(products.stock), style: Theme.of(context).textTheme.titleMedium,)
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5,),
        /// Brand
        Row(
          children: [
            TCircularImage(image: products.brand != null ? products.brand!.image : '',
            width: 32,
            height: 32,
            overlayColor: dark ? TColors.white : TColors.black,),
            TBrandTitleWithVerifiedIcon(title: products.brand != null ? products.brand!.name : '', brandTextSizes: TextSizes.medium,)
          ],
        )
      ],
    );
  }
}


