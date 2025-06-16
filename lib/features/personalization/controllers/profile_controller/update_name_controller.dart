import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/data/repositories/user/user_repository.dart';
import 'package:t_store/features/personalization/controllers/user_controller.dart';
import 'package:t_store/features/personalization/screens/profile/profile.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/helpers/network_manager.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';
import 'package:t_store/utils/popups/loaders.dart';
class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  ///Init user data when Home Screen appears
  @override
  void onInit() {
    initializedName();
    super.onInit();

    //
  }
  /// Fetch user record
  Future<void> initializedName() async {
   firstname.text = userController.user.value.firstName;
   lastname.text = userController.user.value.lastName;
  }


  /// Update User Name
  Future<void> updateUserName() async {

    try {
      /// Start loading
      TFullScreenLoader.openLoadingDialog('We are updating your information...', TImages.docerAnimation);

      /// Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// Form Validation
      if (!updateUserNameFormKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }

      /// Update user first & last Name ib the Firebase Store
      Map<String, dynamic> name = {'FirstName': firstname.text.trim(), 'LastName': lastname.text.trim()};
      await userRepository.updateSingleField(name);

      /// Update the Rx User value
      userController.user.value.firstName = firstname.text.trim();
      userController.user.value.lastName = lastname.text.trim();

      //Remove Loader
      TFullScreenLoader.stopLoading();
      // Show Success Message

      TLoaders.successSnackBar(title: 'Congratulations', message: 'Your Name has been update.');

      // Move to previous screen
      Get.off(() => const ProfileScreen());
    } catch (e) {
     TFullScreenLoader.stopLoading();
     TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

}