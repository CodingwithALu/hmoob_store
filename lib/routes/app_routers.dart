import 'package:get/get.dart';
import 'package:trip_store/features/authentication/screens/login/login.dart';
import 'package:trip_store/features/authentication/screens/onboarding/onboarding.dart';
import 'package:trip_store/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:trip_store/features/authentication/screens/signup/signup.dart';
import 'package:trip_store/features/authentication/screens/signup/widgets/verify_email.dart';
import 'package:trip_store/features/personalization/screens/address/address.dart';
import 'package:trip_store/features/personalization/screens/profile/profile.dart';
import 'package:trip_store/features/personalization/screens/settings/settings.dart';
import 'package:trip_store/features/shop/models/product_model.dart';
import 'package:trip_store/features/shop/screens/cart/cart.dart';
import 'package:trip_store/features/shop/screens/checkout/checkout.dart';
import 'package:trip_store/features/shop/screens/home/home.dart';
import 'package:trip_store/features/shop/screens/order/order.dart';
import 'package:trip_store/features/shop/screens/product/product_details/product_details.dart';
import 'package:trip_store/features/shop/screens/product/product_review/prooduct_review.dart';
import 'package:trip_store/features/shop/screens/store/store.dart';
import 'package:trip_store/features/shop/screens/wishlist/wishlist.dart';
import 'package:trip_store/routes/routes.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: TRoutes.home, page: () => const HomeScreen()),
    GetPage(name: TRoutes.store, page: () => const StoreScreen()),
    GetPage(name: TRoutes.favourites, page: () => const FavouriteScreen()),
    GetPage(name: TRoutes.setting, page: () => const SettingsScreen()),
    GetPage(
      name: TRoutes.productReviews,
      page: () => const ProductReviewScreen(),
    ),
    GetPage(
      name: TRoutes.productDetails,
      page: () => ProductDetailScreen(products: Get.arguments as ProductModel),
    ),
    GetPage(name: TRoutes.order, page: () => const OrderScreen()),
    GetPage(name: TRoutes.checkout, page: () => CheckoutScreen()),
    GetPage(name: TRoutes.cart, page: () => const CartScreen()),
    GetPage(name: TRoutes.userProfile, page: () => const ProfileScreen()),
    GetPage(name: TRoutes.userAddress, page: () => const UserAddressScreen()),
    GetPage(name: TRoutes.signup, page: () => const SignupScreen()),
    GetPage(name: TRoutes.verifyEmail, page: () => const VerifyEmailScreen()),
    GetPage(name: TRoutes.signIn, page: () => const LoginScreen()),
    GetPage(name: TRoutes.forgetPassword, page: () => const ForgetPassWord()),
    GetPage(name: TRoutes.onBoarding, page: () => const OnBoardingScreen()),
  ];
}
