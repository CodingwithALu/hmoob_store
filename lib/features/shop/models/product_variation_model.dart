class ProductVariationModel {
  final String id;
  String sku;
  String image;
  String? description;
  double price;
  double salePrice;
  int stock;
  Map<String, String> attributeValue;

  ProductVariationModel({
    required this.id,
    this.sku = '',
    this.image = '',
    this.description = '',
    this.price = 0.0,
    this.salePrice = 0.0,
    this.stock = 0,
    required this.attributeValue
  });


  /// Create Empty function for clean code
  static ProductVariationModel empty() => ProductVariationModel(id: '', attributeValue: {});
  /// Json Format
  toJson(){
    return {
      'Id': id,
      'Image': image,
      'Description': description,
      'Price': price,
      'SalePrices': salePrice,
      'SKU': sku,
      'Stock': stock,
      'AttributeValues': attributeValue
    };
  }
  
  // Map Json oriented document snapshot from Firebase to Model
  factory ProductVariationModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if(data.isEmpty) return ProductVariationModel.empty();
    return ProductVariationModel(
      id: data['Id'] ?? '',
      price: double.parse((data['Price'] ?? 0.0).toString()),
      sku: data['SKU'] ?? '',
      stock: data['Stock'] ?? 0,
      description: data['Description'] ?? '',
      salePrice: double.parse((data['SalePrices'] ?? 0.0).toString()),
      image: data['Image'] ?? '',
      attributeValue: Map<String, String>.from(data['AttributeValues']),
    );
  }
}