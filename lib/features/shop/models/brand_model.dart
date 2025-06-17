
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
    this.productsCount,}
  );

  //. Empty Helper Function
  static BrandModel empty() => BrandModel(id: '', name: '', image: '');
  /// Convert model to Json structure so that you can data in Firebase

  toJson(){
    return {
      'Id' : id,
      'Name': name,
      'Image': image,
      'ProductsCount': productsCount,
      'IsFeatured': isFeatured
    };
  }
  /// Map Json oriented document snapshot from Firebase to UserModels
  factory BrandModel.fromJson(Map<String, dynamic> document) {
      final data = document;
      return BrandModel(
          id: data['Id'] ?? '',
          name: data['Name'] ?? '',
          image: data['Image'] ?? '',
          productsCount: data['ProductsCount'] ?? '',
          isFeatured: data['IsFeatured'] ?? false
      );
    }
}
