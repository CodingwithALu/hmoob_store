import 'package:get/get.dart';
import 'package:t_store/features/shop/controllers/products/images_controller.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/features/shop/models/product_variation_model.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();

  /// Variable
  RxMap selectedAttribute = {}.obs;
  RxString variationStockStatus = ''.obs;
  Rx<ProductVariationModel> selectedVariation =
      ProductVariationModel.empty().obs;

  @override
  void onInit() {
    getProductVariationStockStatus();
    super.onInit();
  }

  /// Select Attribute and Variation
  void onAttributeSelected(
    ProductModel product,
    attributeName,
    attributeValue,
  ) {
    final selectedAttributes = Map<String, dynamic>.from(selectedAttribute);
    selectedAttributes[attributeName] = attributeValue;
    selectedAttribute[attributeName] = attributeValue;

    final selectedVariable = product.productVariations!.firstWhere(
      (variation) =>
          _isSameAttributeValues(variation.attributeValue, selectedAttributes),
      orElse: () => ProductVariationModel.empty(),
    );
    // Show the selected Variable image as a Main Image
    if (selectedVariable.image.isNotEmpty) {
      ImagesController.instance.selectedProductImage.value =
          selectedVariable.image;
    }
    selectedVariation.value = selectedVariable;
  }

  /// check if selected attribute matches any variable attribute
  bool _isSameAttributeValues(
    Map<String, dynamic> variableAttributes,
    Map<String, dynamic> selectedAttributes,
  ) {
    // If selectedAttributes contain 3 attributes and current variable contains 2 then return
    if (variableAttributes.length != selectedAttributes.length) return false;

    // If nay of the attributes id different then return .e. g [Green, Large] X [Green, Small]
    for (final key in variableAttributes.keys) {
      if (variableAttributes[key] != selectedAttributes[key]) return false;
    }
    return true;
  }

  /// Check Attribute availability
  Set<String?> getAttributesAvailabilityInVariation(
    List<ProductVariationModel> variation,
    String attributeName,
  ) {
    final availableVariationAttributes = variation
        .where(
          (variation) =>
              variation.attributeValue[attributeName] != null &&
              variation.attributeValue[attributeName]!.isNotEmpty &&
              variation.stock > 0,
        )
        .map((variation) => variation.attributeValue[attributeName])
        .toSet();

    return availableVariationAttributes;
  }

  String getVariationPrice() {
    return (selectedVariation.value.salePrice > 0
            ? selectedVariation.value.salePrice
            : selectedVariation.value.price)
        .toString();
  }

  /// Check Product Variation Stock Status
  void getProductVariationStockStatus() {
    variationStockStatus.value = selectedVariation.value.stock > 0
        ? 'In Stock'
        : 'Out of stock';
  }

  /// Reset selected Attribute when switching products
  void resetSelectedAttribute() {
    selectedAttribute.clear();
    variationStockStatus.value = '';
    selectedVariation.value = ProductVariationModel.empty();
  }
}
