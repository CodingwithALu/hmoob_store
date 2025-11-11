import 'dart:convert';

import 'package:get/get.dart';
import 'package:trip_store/data/repositories/products/product_repository.dart';
import 'package:trip_store/features/shop/models/product_model.dart';
import 'package:trip_store/utils/local_storage/storage_utility.dart';
import 'package:trip_store/utils/popups/loaders.dart';

class FavouritesController extends GetxController {
  static FavouritesController get instance => Get.find();

  /// Variables
  final favorites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    initFavorites();
  }

  // Method to initialize favorites by reading from storage
  void initFavorites() {
    final json = TLocalStorage.instance().readData('favorites');
    if (json != null) {
      final storedFavorites = jsonDecode(json) as Map<String, dynamic>;
      favorites.assignAll(
        storedFavorites.map((key, value) => MapEntry(key, value as bool)),
      );
    }
  }

  bool isFavourite(String productId) {
    return favorites[productId] ?? false;
  }

  void toggleFavoriteProduct(
    String productId, {
    String? addedMessage,
    String? removedMessage,
  }) {
    if (!favorites.containsKey(productId)) {
      favorites[productId] = true;
      saveFavoritesToStorage();
      TLoaders.customToast(
        message: addedMessage ?? 'Product has been added to the Wishlist.',
      );
    } else {
      TLocalStorage.instance().removeData(productId);
      favorites.remove(productId);
      saveFavoritesToStorage();
      favorites.refresh();
      TLoaders.customToast(
        message:
            removedMessage ?? 'Product has been removed from the Wishlist.',
      );
    }
  }

  void saveFavoritesToStorage() {
    final encodedFavorites = json.encode(favorites);
    TLocalStorage.instance().writeData('favorites', encodedFavorites);
  }

  Future<List<ProductModel>> favoriteProducts() async {
    return await ProductRepository.instance.getFavouriteProducts(
      favorites.keys.toList(),
    );
  }
}
