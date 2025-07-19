import 'package:get/get.dart';
import 'package:hmoob_store/data/repositories/brand/brands_repository.dart';
import 'package:hmoob_store/data/repositories/products/product_repository.dart';
import 'package:hmoob_store/features/shop/models/brand_model.dart';
import 'package:hmoob_store/features/shop/models/product_model.dart';
import 'package:hmoob_store/utils/popups/loaders.dart';

class BrandsContorller extends GetxController {
  static BrandsContorller get instance => Get.find();
  RxBool isLoading = true.obs;
  final RxList<BrandModel> featureBrands = <BrandModel>[].obs;
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final brandRepository = Get.put(BrandsRepository());

  @override
  void onInit() {
    getFeaturedBrands();
    super.onInit();
  }

  // Loader brands
  Future<void> getFeaturedBrands() async {
    try {
      // Show loader while loading Brands
      isLoading.value = true;

      final brands = await brandRepository.getAllBrands();

      allBrands.assignAll(brands);

      featureBrands.assignAll(
        allBrands.where((brand) => brand.isFeatured ?? false).take(4),
      );
    } catch (e) {
      // Handle error here
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Get Brand Specific Products from your data source
  Future<List<ProductModel>> getBrandProducts(String brandId) async {
    try {
      final products = await ProductRepository.instance.getProductsForBrand(
        brandId: brandId,
      );
      return products;
    } catch (e) {
      // Handle error here
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
      return [];
    }
  }

  /// Get Brand Specific Products from your data source
  Future<List<BrandModel>> getBrandforCategory(String categoryId) async {
    try {
      final brands = await brandRepository.getBrandsForCategory(categoryId);
      return brands;
    } catch (e) {
      // Handle error here
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
      return [];
    }
  }
}
