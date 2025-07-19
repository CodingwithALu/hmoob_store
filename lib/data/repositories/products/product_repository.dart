import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hmoob_store/features/shop/models/product_model.dart';
import 'package:hmoob_store/utils/exceptions/firebase_exceptions.dart';
import 'package:hmoob_store/utils/exceptions/platform_exceptions.dart';

import '../../../utils/constants/enums.dart';
import '../../services/firebase_storage_services.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  /// FirebaseStore instance for database interactions
  final _db = FirebaseFirestore.instance;

  /// Get limited featured product
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('IsFeatured', isEqualTo: true)
          .limit(4)
          .get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get all featured product
  Future<List<ProductModel>> getAllFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('IsFeatured', isEqualTo: true)
          .get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get limited featured product
  Future<List<ProductModel>> fetchProductByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<ProductModel> productList = querySnapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
      return productList;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get All Product
  Future<List<ProductModel>> fetchAllProducts() async {
    try {
      final snapshot = await _db.collection('Products').get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get limited featured product
  Future<List<ProductModel>> getProductsForBrand({
    required String brandId,
    int limit = -1,
  }) async {
    try {
      final querySnapshot = limit == -1
          ? await _db
                .collection('Products')
                .where('Brand.Id', isEqualTo: brandId)
                .get()
          : await _db
                .collection('Products')
                .where('Brand.Id', isEqualTo: brandId)
                .limit(limit)
                .get();

      final products = querySnapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();

      return products;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get limited featured product
  Future<List<ProductModel>> getProductsForCategory({
    required String categoryId,
    int limit = 4,
  }) async {
    try {
      // Query to get all documents where productId matches the provided categoryId & Fetch limited or unlimited based on limit
      QuerySnapshot productCategoryQuery = limit == -1
          ? await _db
                .collection('ProductCategories')
                .where('categoryId', isEqualTo: categoryId)
                .get()
          : await _db
                .collection('ProductCategories')
                .where('categoryId', isEqualTo: categoryId)
                .limit(limit)
                .get();

      // Extract productIds from the documents
      List<String> productIds = productCategoryQuery.docs
          .map((doc) => doc['ProductId'] as String)
          .toList();

      // Query to get all documents where the productId is in the list of productIds, FieldPath.documentId to query documents in Collection
      final productsQuery = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();

      // Extract product data from the documents
      List<ProductModel> products = productsQuery.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();

      return products;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<ProductModel>> getFavouriteProducts(
    List<String> productIds,
  ) async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();
      return snapshot.docs
          .map((item) => ProductModel.fromSnapshot(item))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Upload dummy data to the Cloud Firebase
  Future<void> uploadDummyData(List<ProductModel> products) async {
    try {
      final storage = Get.put(TFirebaseStorageService());
      // Loop through each product
      for (var product in products) {
        final thumbnail = await storage.getImageFormAssets(product.thumbnail);

        //Upload image and get its URL
        final url = await storage.uploadImageData(
          'Products/Images',
          thumbnail,
          product.thumbnail.toString(),
        );

        // Assign URL to product.thumbnail attribute
        product.thumbnail = url;
        // Product list of image
        if (product.images != null && product.images!.isNotEmpty) {
          List<String> imageUrl = [];
          for (var image in product.images!) {
            // Get image data link local assets
            final assetImage = await storage.getImageFormAssets(image);
            // Upload image and get its URL
            final url = await storage.uploadImageData(
              'Products/Images',
              assetImage,
              image,
            );

            // Assign image
            imageUrl.add(url);
          }

          // Upload Variation Images
          product.images!.clear();
          product.images!.addAll(imageUrl);
        }
        if (product.productType == ProductType.variable.toString()) {
          for (var variable in product.productVariations!) {
            // Get image data link from local assets
            await storage.getImageFormAssets(variable.image);
            //Upload URL
            final url = await storage.uploadImageData(
              'Products/Images',
              thumbnail,
              variable.image,
            );

            // Assign URl to Variation.image attribute
            variable.image = url;
          }
        }
      }
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }
}
