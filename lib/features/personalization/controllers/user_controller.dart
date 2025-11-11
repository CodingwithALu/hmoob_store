import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trip_store/data/repositories/authentication/authentication_repository.dart';
import 'package:trip_store/data/repositories/user/user_repository.dart';
import 'package:trip_store/features/authentication/screens/login/login.dart';
import 'package:trip_store/features/personalization/screens/profile/widgets/reAuth_login.dart';
import 'package:trip_store/l10n/app_localizations.dart';
import 'package:trip_store/utils/popups/full_screen_loader.dart';
import 'package:trip_store/utils/popups/loaders.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/network_manager.dart';
import '../models/user_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());
  final profileLoading = false.obs;
  final hidePassword = false.obs;
  final imageUploading = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();
  @override
  void onInit() {
    fetchUserRecord();
    super.onInit();
  }

  // Fetch ủser Record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
      profileLoading.value = false;
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  /// Save user Record from any Registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    final context = Get.context!;
    final localizations = AppLocalizations.of(context)!;
    try {
      await fetchUserRecord();
      if (user.value.id.isEmpty) {
        if (userCredentials != null) {
          // Convert Name to First and Last Name
          final nameParts = UserModel.nameParts(
            userCredentials.user!.displayName ?? '',
          );
          final username = UserModel.generateUsername(
            userCredentials.user!.displayName ?? '',
          );

          //Map Data
          final user = UserModel(
            id: userCredentials.user!.uid,
            username: username,
            email: userCredentials.user!.email ?? '',
            firstName: nameParts[0],
            lastName: nameParts.length > 1
                ? nameParts.sublist(1).join(' ')
                : ' ',
            phoneNumber: userCredentials.user!.phoneNumber ?? '',
            profilePicture: userCredentials.user!.photoURL ?? '',
          );

          // Save user data
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      TLoaders.warningSnackBar(
        title: localizations.dataNotSaved,
        message: localizations.dataNotSavedMessage,
      );
    }
  }

  // Delete Account Warning
  Future<void> deleteAccountWarningPopup() async {
    final context = Get.context!;
    final localizations = AppLocalizations.of(context)!;
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(TSizes.md),
      title: localizations.deleteAccountTitle,
      middleText: localizations.deleteAccountMessage,
      confirm: ElevatedButton(
        onPressed: () => deleteUserAccount(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.lg),
          child: Text(localizations.deleteAccountConfirm),
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: Text(localizations.deleteAccountCancel),
      ),
    );
  }

  // Delete User Account
  void deleteUserAccount() async {
    final context = Get.context!;
    final localizations = AppLocalizations.of(context)!;
    try {
      TFullScreenLoader.openLoadingDialog(
        localizations.processing,
        TImages.docerAnimation,
      );

      /// First re_Authentication user
      final auth = AuthenticationRepository.instance;
      final provider = auth.authUser!.providerData
          .map((e) => e.providerId)
          .first;
      if (provider.isNotEmpty) {
        // re verify Auth Email
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          TFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          TFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginScreen());
        }
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(
        title: localizations.ohSnap,
        message: e.toString(),
      );
    }
  }

  // Re_ Authentication
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    final context = Get.context!;
    final localizations = AppLocalizations.of(context)!;
    try {
      TFullScreenLoader.openLoadingDialog(
        localizations.processing,
        TImages.docerAnimation,
      );

      // Check Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // Validate
      if (!reAuthFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // Login user using Email & password Authentication
      await AuthenticationRepository.instance
          .reAuthenticationWithEmailAndPassword(
            verifyEmail.text.trim(),
            verifyPassword.text.trim(),
          );
      await AuthenticationRepository.instance.deleteAccount();
      //Remove Loader
      TFullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(
        title: localizations.ohSnap,
        message: e.toString(),
      );
    }
  }

  // Upload Profile Image
  void uploadUseProfilePicture() async {
    final context = Get.context!;
    final localizations = AppLocalizations.of(context)!;
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );
      if (image != null) {
        imageUploading.value = true;
        // Upload Images
        final imageUrl = await userRepository.uploadImage(
          'Users/Images/Profile',
          image,
        );
        // Update User Image
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};

        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageUrl;
        user.refresh();
        TLoaders.successSnackBar(
          title: localizations.congratulations,
          message: localizations.profileImageUpdated,
        );
      }
    } on Exception catch (e) {
      TLoaders.errorSnackBar(
        title: localizations.ohSnap,
        message: '${localizations.somethingWentWrong}: $e',
      );
    } finally {
      imageUploading.value = false;
    }
  }
}
