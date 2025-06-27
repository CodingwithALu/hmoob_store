import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store/features/shop/models/product_attribute_model.dart';
import 'package:t_store/features/shop/models/product_variation_model.dart';

import 'brand_model.dart';

class ProductModel {
  String id;
  int stock;
  String? sku;
  double price;
  String title;
  DateTime? date;
  double salePrices;
  String thumbnail;
  bool? isFeatured;
  BrandModel? brand;
  String? description;
  String? categoryId;
  List<String>? images;
  String productType;
  List<ProductAttributeModel>? productAttributeModel;
  List<ProductVariationModel>? productVariations;

  ProductModel({
    required this.id,
    required this.title,
    required this.stock,
    required this.price,
    required this.thumbnail,
    required this.productType,
    this.sku,
    this.brand,
    this.date,
    this.images,
    this.salePrices = 0.0,
    this.isFeatured,
    this.categoryId,
    this.description,
    this.productAttributeModel,
    this.productVariations
  });

  /// Create Empty func for clean code
  static ProductModel empty() => ProductModel(id: '', title: '', stock: 0, price: 0, thumbnail: '', productType: '');

  /// Json Format
  toJson() {
    return {
      'Title': title,
      'SKU': sku,
      'Stock': stock,
      'Price': price,
      'Image': images,
      'Thumbnail': thumbnail,
      'SalePrice': salePrices,
      'IsFeatured': isFeatured,
      'CategoryId': categoryId,
      'Brand': brand!.toJson(),
      'Description': description,
      'ProductType': productType,
      'ProductAttributeModel': productAttributeModel,
      'ProductVariations': productVariations
    };
  }
  // Map Jon oriented document snapshot from Firebase to Model
  factory ProductModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return ProductModel(
          id: document.id,
          sku: data['SKU'] ?? '',
          title: data['Title'] ?? '',
          stock: data['Stock'] ?? 0,
          price: double.parse((data['Price'] ?? 0.0).toString()),
          salePrices: double.parse((data['SalePrices'] ?? 0.0).toString()),
          thumbnail: data['Thumbnail'] ?? '',
          categoryId: data['CategoryId'] ?? '',
          description: data['Description'] ?? '',
          productType: data['ProductType'] ?? '',
          brand: BrandModel.fromJson(data['Brand']),
          images: data['Images'] != null ? List<String>.from(data['Images']) : [],
          productAttributeModel: (data['ProductAttributeModel'] as List<dynamic>).map((e) => ProductAttributeModel.fromJson(e)).toList(),
          productVariations: (data['ProductVariations'] as List<dynamic>).map((e) => ProductVariationModel.fromJson(e)).toList(),
          isFeatured: data['IsFeatured'] ?? false
      );
    }else {
      return ProductModel.empty();
    }
  }
  // Map Jon-oriented document snapshot from Firebase to Model
  factory ProductModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
    if (document.data() != null) {
      final data = document.data() as Map<String, dynamic>;
      return ProductModel(
          id: document.id,
          sku: data['SKU'] ?? '',
          title: data['Title'] ?? '',
          stock: data['Stock'] ?? 0,
          price: double.parse((data['Price'] ?? 0.0).toString()),
          salePrices: double.parse((data['SalePrices'] ?? 0.0).toString()),
          thumbnail: data['Thumbnail'] ?? '',
          categoryId: data['CategoryId'] ?? '',
          description: data['Description'] ?? '',
          productType: data['ProductType'] ?? '',
          brand: BrandModel.fromJson(data['Brand']),
          images: data['Images'] != null ? List<String>.from(data['Images']) : [],
          productAttributeModel: (data['ProductAttributeModel'] as List<dynamic>).map((e) => ProductAttributeModel.fromJson(e)).toList(),
          productVariations: (data['ProductVariations'] as List<dynamic>).map((e) => ProductVariationModel.fromJson(e)).toList(),
          isFeatured: data['IsFeatured'] ?? false
      );
    }else {
      return ProductModel.empty();
    }
  }
}
