import 'package:get/get.dart';
import 'package:trip_store/data/repositories/categories/category_repository.dart';
import 'package:trip_store/data/repositories/products/product_repository.dart';
import 'package:trip_store/features/shop/models/category_model.dart';
import 'package:trip_store/features/shop/models/product_model.dart';
import 'package:trip_store/utils/popups/loaders.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featureCategories = <CategoryModel>[].obs;
  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  Future<void> fetchCategories() async {
    try {
      /// Todo -- Show loader while loading categories
      isLoading.value = true;

      /// Fetch categories from data source (Firebase, API, etc...)
      final categories = await _categoryRepository.getAllCategories();

      /// Update the categories list
      allCategories.assignAll(categories);

      /// filter featured categories
      featureCategories.assignAll(
        allCategories
            .where(
              (category) => category.isFeatured && category.parentId.isEmpty,
            )
            .take(8)
            .toList(),
      );
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      /// Todo -- Remove Loader
      isLoading.value = false;
    }
  }

  /// Load Category data
  /// Todo -- Load Selected category data
  /// Todo --  Get Category or Sub_Category Product
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    // Fetch limited (4) products against each subCategory;
    try {
      final subCategories = await _categoryRepository.getSubCategories(
        categoryId,
      );
      return subCategories;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  /// Get Category or Sub-Category Products.
  Future<List<ProductModel>> getCategoryProducts({
    required String categoryId,
    int limit = 4,
  }) async {
    // Fetch limited (4) products against each subCategory;
    final products = await ProductRepository.instance.getProductsForCategory(
      categoryId: categoryId,
      limit: limit,
    );
    return products;
  }
}
