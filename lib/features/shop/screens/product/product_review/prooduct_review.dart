import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/features/shop/screens/product/product_review/widgets/rating_product_indicator.dart';
import 'package:t_store/features/shop/screens/product/product_review/widgets/user_review_card.dart';

import '../../../../../common/widgets/products/ratings/rating_indicator.dart';
import '../../../../../utils/constants/sizes.dart';

class ProductReviewScreen extends StatelessWidget {
  const ProductReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // implement build
    return Scaffold(
      /// AppBar
      appBar: TAppBar(title: Text('Review & Rating'), showBackArrow: true),

      /// Body
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ratings and reviews are verifies and are from people who use the same type of device that you use',
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Overall Product Ratings
              const TOverallProductRating(),
              const TRatingBarIndicator(rating: 4.8),
              Text('12, 611', style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// User Review List
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}
