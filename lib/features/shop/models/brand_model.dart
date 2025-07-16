import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id;
  String name;
  String image;
  bool? isFeatured;
  int? productsCount;

  BrandModel({
    required this.id,
    required this.name,
    required this.image,
    this.isFeatured,
    this.productsCount,
  });

  //. Empty Helper Function
  static BrandModel empty() => BrandModel(id: '', name: '', image: '');

  /// Convert model to Json structure so that you can data in Firebase

  toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'ProductCount': productsCount,
      'IsFeatures': isFeatured,
    };
  }

  /// Map Json oriented document snapshot from Firebase to UserModels
  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    return BrandModel(
      id: data['Id'] ?? '',
      name: data['Name'] ?? '',
      image: data['Image'] ?? '',
      productsCount: data['ProductCount'] ?? '',
      isFeatured: data['IsFeatures'] ?? false,
    );
  }
  // Map Jdon oriented document snapshot for Firebase to CategoryModels
  factory BrandModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data()!;
      // Map Json Record to the Model
      return BrandModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        isFeatured: data['IsFeatures'] ?? false,
        productsCount: data['ProductCount'] ?? '',
      );
    } else {
      return BrandModel.empty();
    }
  }
}
