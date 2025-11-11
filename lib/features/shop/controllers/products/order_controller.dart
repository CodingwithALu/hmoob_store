import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_store/common/widgets/success_screen/success_screen.dart';
import 'package:trip_store/data/repositories/authentication/authentication_repository.dart';
import 'package:trip_store/data/repositories/products/order_repository.dart';
import 'package:trip_store/features/personalization/controllers/address_controller.dart';
import 'package:trip_store/features/shop/controllers/checkouts/checkout_controller.dart';
import 'package:trip_store/features/shop/controllers/products/cart_controller.dart';
import 'package:trip_store/features/shop/models/order_model.dart';
import 'package:trip_store/navigation_menu.dart';
import 'package:trip_store/utils/constants/enums.dart';
import 'package:trip_store/utils/constants/image_strings.dart';
import 'package:trip_store/utils/popups/full_screen_loader.dart';
import 'package:trip_store/utils/popups/loaders.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  /// Variables
  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = Get.put(CheckoutController());
  final orderRepository = Get.put(OrderRepository());

  /// Fetch user's order history
  Future<List<OrderModel>> fetchUserOrders({String? errorTitle}) async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      TLoaders.warningSnackBar(
        title: errorTitle ?? 'Oh Snap!',
        message: e.toString(),
      );
      return [];
    }
  }

  /// Add methods for order processing
  void processOrder(
    double totalAmount, {
    String? processingMessage,
    String? successTitle,
    String? successSubtitle,
    String? errorTitle,
  }) async {
    try {
      // Start Loader
      TFullScreenLoader.openLoadingDialog(
        processingMessage ?? 'Processing your order',
        TImages.pencilAnimation,
      );

      // Get user authentication Id
      final userId = AuthenticationRepository.instance.authUser?.uid;
      if (userId == null || userId.isEmpty) return;
      // Add Details
      final order = OrderModel(
        // Generate a unique ID for the order
        id: UniqueKey().toString(),
        userId: userId,
        status: OrderStatus.pending,
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        paymentMethod: checkoutController.selectecPaymentMethod.value.name,
        shippingAddress: addressController.selectedAddress.value,
        // Set Date as needed
        deliveryDate: DateTime.now(),
        items: cartController.cartItems.toList(),
      ); // OrderModel

      // Save the order to Firestore
      await orderRepository.saveOrder(order);
      // Update the cart status
      cartController.cleanCart();
      TFullScreenLoader.stopLoading();
      // Show success screen
      Get.to(
        () => SuccessScreen(
          showEmail: false,
          image: TImages.orderCompletedAnimation,
          title: successTitle ?? 'Payment Success!',
          subtitle: successSubtitle ?? 'Your item will be shpipped soon!',
          onPressed: () {
            Get.offAll(() => NavigationMenu());
          },
        ),
      );
    } catch (e) {
      TLoaders.errorSnackBar(
        title: errorTitle ?? 'Oh Snap',
        message: e.toString(),
      );
    }
  }
}
