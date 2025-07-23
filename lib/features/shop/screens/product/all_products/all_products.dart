import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_store/common/widgets/appbar/appbar.dart';
import 'package:trip_store/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:trip_store/features/shop/controllers/products/all_products_contorller.dart';
import 'package:trip_store/utils/helpers/cloud_helper_functions.dart';

import '../../../../../common/widgets/products/sortable/sortable_product.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../models/product_model.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({
    super.key,
    required this.title,
    this.query,
    this.futureMethod,
  });

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductController());
    return Scaffold(
      appBar: TAppBar(title: Text(title), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: FutureBuilder(
            future: futureMethod ?? controller.fetchProductsByQuery(query),
            builder: (context, asyncSnapshot) {
              const loader = TVerticalProductShimmer();
              final widget = TCloudHelperFunctions.checkMultiRecordState(
                snapshot: asyncSnapshot,
                loader: loader,
              );
              if (widget != null) return widget;
              final products = asyncSnapshot.data!;
              return TSortableProducts(products: products);
            },
          ),
        ),
      ),
    );
  }
}
