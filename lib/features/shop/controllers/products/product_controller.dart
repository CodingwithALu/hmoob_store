import 'package:get/get.dart';
import 'package:t_store/data/repositories/products/product_repository.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/popups/loaders.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();
  final isLoading = false.obs;
  final _productRepository = Get.put(ProductRepository());
  RxList<ProductModel> featureProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();

    //
  }
  void fetchFeaturedProducts() async {
    try {
      // Show loader while loading Products
      final products = await _productRepository.getFeaturedProducts();
      //Fetch Product;
      featureProducts.assignAll(products);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  void fetchAllFeaturedProducts() async {
    try {
      isLoading.value = true;
      // Show loader while loading Products
      final products = await _productRepository.getFeaturedProducts();
      //Fetch Product;
      featureProducts.assignAll(products);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  /// Get the product price ur price range for variable
  String getProductPrice(ProductModel products){
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;

    if (products.productType == ProductType.single.toString()) {
      return (products.salePrices > 0 ? products.salePrices : products.price).toString();
    } else {
      // Calculate the smallest and largest prices among variable
      for (var variable in products.productVariations!){
        double priceToConsider = variable.salePrice > 0.0 ? variable.salePrice : variable.price;

        // Update smallest and largest prices
        if (priceToConsider < smallestPrice){
          smallestPrice = priceToConsider;
        }
        if (priceToConsider > largestPrice){
          largestPrice = priceToConsider;
        }
      }
      // If smallest and largest prices are the same, return a single price
      if (smallestPrice.isEqual(largestPrice)){
        return largestPrice.toString();
      }else {
        // Otherwise
        return '$smallestPrice - \$$largestPrice';
      }
    }
  }
  /// Calculate Discount Percentage
  String? calculatePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }
  /// Check Product Stock Status
  String getProductStockStatus(int stock) {
    return stock > 0 ? 'In stock' : 'Out of stock';
  }
}