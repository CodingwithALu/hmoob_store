import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmoob_store/data/repositories/authentication/authentication_repository.dart';
import 'package:hmoob_store/utils/constants/image_strings.dart';
import 'package:hmoob_store/utils/helpers/network_manager.dart';
import 'package:hmoob_store/utils/popups/full_screen_loader.dart';
import 'package:hmoob_store/utils/popups/loaders.dart';

import '../../screens/password_configuration/reset_passsword.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  /// Variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFromKey = GlobalKey<FormState>();

  /// Sent Reset password Email
  Future<void> sendPasswordResetEmail() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
        'Processing your request...',
        TImages.docerAnimation,
      );
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // Form Validation
      if (!forgetPasswordFromKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // Send EMail to reset password
      await AuthenticationRepository.instance.sendPasswordResetEmail(
        email.text.trim(),
      );

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Show Success Screen
      TLoaders.successSnackBar(
        title: 'Email Sent',
        message: 'Email link Sent to reset your Password',
      );

      // Redirect
      Get.to(() => ResetPassword(email: email.text.trim()));
    } catch (e) {
      // Remove Loader
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'On Snap', message: e.toString());
    }
  }

  Future<void> resendPassWordResetEmail(String email) async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
        'Processing your request...',
        TImages.docerAnimation,
      );
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // Form Validation
      if (!forgetPasswordFromKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // Send EMail to reset password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);
      // Remove Loader
      TFullScreenLoader.stopLoading();
      // Show Success Screen
      TLoaders.successSnackBar(
        title: 'Email Sent',
        message: 'Email link Sent to reset your Password',
      );
    } catch (e) {
      // Remove Loader
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'On Snap', message: e.toString());
    }
  }
}
