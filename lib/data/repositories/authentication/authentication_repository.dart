import 'package:firebase_auth/firebase_auth.dart';
// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// ignore: unused_import
import 'package:t_store/features/authentication/controllers/signup/verify_email_controller.dart';
import 'package:t_store/features/authentication/screens/login/login.dart';
import 'package:t_store/features/authentication/screens/onboarding/onboarding.dart';
import 'package:t_store/features/authentication/screens/signup/widgets/verify_email.dart';
import 'package:t_store/navigation_menu.dart';
import 'package:t_store/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:t_store/utils/exceptions/firebase_exceptions.dart';
import 'package:t_store/utils/exceptions/platform_exceptions.dart';
class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();


  /// Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;
  /// Called from main.dart on app launch
  @override
  void onReady(){
    FlutterNativeSplash.remove();
    screenRedirect();
  }
  /// Function to show Relevant Screen
  screenRedirect() async{
    /// Todo -- Local Storage
    final user = _auth.currentUser;
    if (user != null){
      if (user.emailVerified){
        Get.offAll(() => const NavigationMenu());
      } else {
         Get.offAll(() => VerifyEmailScreen(email: user.email));
      }
    } else {
      deviceStorage.writeIfNull('isFirstTime', true);
      deviceStorage.read('isFirstTime') != true ? Get.offAll(() => const LoginScreen()) : Get.offAll(() => const OnBoardingScreen());
    }
  }
  /*---------------------------------------- Email & Password sign-in ----------------------------------------*/

  /// Todo --  EmailAuthentication - SignIn
  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async{
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch(_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }
  /// Todo --  EmailAuthentication - REGISTER
  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async{
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch(_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  /// Todo -- sendEmailVerification - Main VERIFICATION
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on TFirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    } on TFirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } on FormatException catch(_){
      throw FormatException();
    } catch (e){
      throw 'Something went wrong. Please try again';
    }
  }
  /// Todo -- sendEmailVerification - LogoutUser
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on TFirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    } on TFirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } on FormatException catch(_){
      throw FormatException();
    } catch (e){
      throw 'Something went wrong. Please try again';
    }
  }

  /// Todo --
}