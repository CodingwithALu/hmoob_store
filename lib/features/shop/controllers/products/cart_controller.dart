import 'package:get/get.dart';
import 'package:trip_store/features/shop/controllers/products/variation_controller.dart';
import 'package:trip_store/features/shop/models/cart_item_model.dart';
import 'package:trip_store/features/shop/models/product_model.dart';
import 'package:trip_store/utils/constants/enums.dart';
import 'package:trip_store/utils/local_storage/storage_utility.dart';
import 'package:trip_store/utils/popups/loaders.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();
  // Variable
  RxInt noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final variationController = VariationController.instance;
  CartController() {
    loadCartItems();
  }
  // Add items in the cart
  void addToCart(ProductModel product) {
    // Quantity Check
    if (productQuantityInCart.value < 1) {
      TLoaders.customToast(message: 'Select Quantity');
      return;
    }

    // Variation Selected?
    if (product.productType == ProductType.variable.toString() &&
        variationController.selectedVariation.value.id.isEmpty) {
      TLoaders.customToast(message: 'Select Variation');
      return;
    }

    // Out of Stock Status
    if (product.productType == ProductType.variable.toString()) {
      if (variationController.selectedVariation.value.stock < 1) {
        TLoaders.warningSnackBar(
          message: 'Selected variation is out of stock.',
          title: 'Oh Snap!',
        );
        return;
      }
    } else {
      if (product.stock < 1) {
        TLoaders.warningSnackBar(
          message: 'Selected product is out of stock.',
          title: 'Oh Snap!',
        );
        return;
      }
    }
    final selectedCartItem = convertToCartItem(
      product,
      productQuantityInCart.value,
    );
    int index = cartItems.indexWhere(
      (item) =>
          item.productId == selectedCartItem.productId &&
          item.variationId == selectedCartItem.variationId,
    );
    if (index >= 0) {
      cartItems[index].quantity = selectedCartItem.quantity;
    } else {
      cartItems.add(selectedCartItem);
    }

    updateCart();
    TLoaders.customToast(message: 'Your Product has been added to the Cart');
  }

  void addOneToCart(CartItemModel item) {
    int index = cartItems.indexWhere(
      (cartItem) =>
          cartItem.productId == item.productId &&
          cartItem.variationId == item.variationId,
    );
    if (index >= 0) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(item);
    }
    updateCart();
  }

  void removeOneFromCart(CartItemModel item) {
    int index = cartItems.indexWhere(
      (cartItem) =>
          cartItem.productId == item.productId &&
          cartItem.variationId == item.variationId,
    );
    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      } else {
        cartItems[index].quantity == 1
            ? removeFromCartDialog(index)
            : cartItems.removeAt(index);
      }
      updateCart();
    }
  }

  /// This function converts a ProductModel to a CartItemModel
  CartItemModel convertToCartItem(ProductModel product, int quantity) {
    if (product.productType == ProductType.single.toString()) {
      // Reset Variation in case of single product type.
      variationController.resetSelectedAttribute();
    }

    final variation = variationController.selectedVariation.value;
    final isVariation = variation.id.isNotEmpty;
    final price = isVariation
        ? variation.salePrice > 0.0
              ? variation.salePrice
              : variation.price
        : product.salePrices > 0.0
        ? product.salePrices
        : product.price;

    return CartItemModel(
      productId: product.id,
      title: product.title,
      price: price,
      quantity: quantity,
      variationId: variation.id,
      image: isVariation ? variation.image : product.thumbnail,
      brandName: product.brand != null ? product.brand!.name : '',
      selectedVariation: isVariation ? variation.attributeValue : null,
    );
  }

  void updateCart() {
    updateCartToltals();
    saveCartItem();
    cartItems.refresh();
  }

  void updateCartToltals() {
    double calculatedTotalPrice = 0.0;
    int calculatedNoOfItems = 0;
    for (var item in cartItems) {
      calculatedTotalPrice += (item.price) * item.quantity.toDouble();
      calculatedNoOfItems += item.quantity;
    }
    totalCartPrice.value = calculatedTotalPrice;
    noOfCartItems.value = calculatedNoOfItems;
  }

  void saveCartItem() {
    final cartItemsStrings = cartItems.map((item) => item.toJson()).toList();
    TLocalStorage.instance().writeData('cartItems', cartItemsStrings);
  }

  void loadCartItems() {
    final cartItemString = TLocalStorage.instance().readData<List<dynamic>>(
      'cartItems',
    );
    if (cartItemString != null) {
      cartItems.assignAll(
        cartItemString.map(
          (item) => CartItemModel.fromJson(item as Map<String, dynamic>),
        ),
      );
      updateCartToltals();
    }
  }

  int getProductQuantityInCart(String productId) {
    final foudItem = cartItems
        .where((item) => item.productId == productId)
        .fold(0, (previosValue, elemt) => previosValue + elemt.quantity);
    return foudItem;
  }

  int getVariationQuantityInCart(String productId, String variationId) {
    final foudItem = cartItems.firstWhere(
      (item) => item.productId == productId && item.variationId == variationId,
      orElse: () => CartItemModel.empty(),
    );
    return foudItem.quantity;
  }

  void cleanCart() {
    productQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }

  void removeFromCartDialog(int index) {
    Get.defaultDialog(
      title: 'Remove Product',
      middleText: 'Are you sure you want to remove this product?',
      onConfirm: () {
        // Remove the item from the cart
        cartItems.removeAt(index);
        updateCart();
        TLoaders.customToast(message: 'Product removed from the Cart.');
        Get.back();
      },
      onCancel: () =>
          () => Get.back(),
    );
  }

  /// -- Initialize already added Item's Count in the cart.
  void updateAlreadyAddedProductCount(ProductModel product) {
    // If product has no variations then calculate cartEntries and display total number.
    // Else make default entries to 0 and show cartEntries when variation is selected.
    if (product.productType == ProductType.single.toString()) {
      productQuantityInCart.value = getProductQuantityInCart(product.id);
    } else {
      // Get selected Variation if any...
      final variationId = variationController.selectedVariation.value.id;
      if (variationId.isNotEmpty) {
        productQuantityInCart.value = getVariationQuantityInCart(
          product.id,
          variationId,
        );
      } else {
        productQuantityInCart.value = 0;
      }
    }
  }
}
