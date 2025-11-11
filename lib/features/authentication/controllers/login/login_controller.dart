import 'package:trip_store/features/authentication/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trip_store/data/repositories/authentication/authentication_repository.dart';
import 'package:trip_store/features/personalization/controllers/user_controller.dart';
import 'package:trip_store/utils/constants/image_strings.dart';
import 'package:trip_store/utils/helpers/network_manager.dart';
import 'package:trip_store/utils/popups/full_screen_loader.dart';
import 'package:trip_store/utils/popups/loaders.dart';

class LoginController extends GetxController {
  // variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());
  @override
  void onInit() {
    final savedEmail = localStorage.read('REMEMBER_ME_EMAIL');
    if (savedEmail != null) {
      email.text = savedEmail;
    }

    final savedPassword = localStorage.read('REMEMBER_ME_PASSWORD');
    if (savedPassword != null) {
      password.text = savedPassword;
    }
    super.onInit();
  }

  /// Todo -- Email and Password SignIn
  Future<void> emailAndPasswordSignIn() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
        'Logging you in ...',
        TImages.docerAnimation,
      );
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // Save Data if Remember Me is Selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }
      // Login user using Email & password Authentication
      await AuthenticationRepository.instance.loginWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );

      //Remove Loader
      TFullScreenLoader.stopLoading();
      // Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  /// Todo -- Google SignIn Authentication
  Future<void> googleSignIn() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
        'Logging you in...',
        TImages.docerAnimation,
      );
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // Google Authentication
      final userCredentials = await AuthenticationRepository.instance
          .signInWithGoogle();

      // Save User Record
      await userController.saveUserRecord(userCredentials);
      // Remove Loader
      TFullScreenLoader.stopLoading();

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  /// Đăng xuất tài khoản
  Future<void> logout() async {
    try {
      // Hiển thị loading
      TFullScreenLoader.openLoadingDialog(
        'Đang đăng xuất...',
        TImages.docerAnimation,
      );
      // Thực hiện đăng xuất
      await AuthenticationRepository.instance.logout();
      // Xóa thông tin Remember Me nếu có
      localStorage.remove('REMEMBER_ME_EMAIL');
      localStorage.remove('REMEMBER_ME_PASSWORD');
      // Ẩn loading
      TFullScreenLoader.stopLoading();
      // Hiển thị thông báo thành công
      TLoaders.successSnackBar(
        title: 'Thành công',
        message: 'Bạn đã đăng xuất thành công.',
      );
      // Chuyển hướng về màn hình đăng nhập
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Lỗi', message: e.toString());
    }
  }
}
