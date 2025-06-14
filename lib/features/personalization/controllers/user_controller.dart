import 'dart:js_interop';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:t_store/data/repositories/user/UserRepository.dart';
import 'package:t_store/utils/popups/loaders.dart';

import '../models/user_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());
  final profileLoading = false.obs;
  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
   GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();
  @override
  void onInit() {
    fetchUserRecord();
    super.onInit();
  }

  /// Save user Record from any Registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      if (userCredentials != null) {
        // Convert Name to First and Last Name
        final nameParts = UserModel.nameParts(
            userCredentials.user!.displayName ?? '');
        final username = UserModel.generateUsername(
            userCredentials.user!.displayName ?? '');

        //Map Data
        final user = UserModel(id: userCredentials.user!.uid,
            username: username,
            email: userCredentials.user!.email ?? '',
            firstName: nameParts[0],
            lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' '): ' ',
            phoneNumber: userCredentials.user!.phoneNumber ?? '',
            profilePicture: userCredentials.user!.photoURL?? '');

        // Save user data
        await userRepository.saveUserRecord(user);
      }
    } catch (e) {
      TLoaders.warningSnackBar(title: 'Data not saved',
          message: 'Something went wrong while saving your information. You can re-save your data in your Profile');
    }
  }

  Future<void> fetchUserRecord() async{
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserRecord();
      this.user(user);
      profileLoading.value = false;
    } catch (e){
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }
}