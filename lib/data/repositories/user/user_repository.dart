// ignore_for_file: file_names
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trip_store/data/repositories/authentication/authentication_repository.dart';
import 'package:trip_store/features/personalization/models/user_model.dart';
import 'package:trip_store/utils/exceptions/firebase_exceptions.dart';
import 'package:trip_store/utils/exceptions/format_exceptions.dart';
import 'package:trip_store/utils/exceptions/platform_exceptions.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  // Connect Cloudinary use HTTP
  final String cloudName = 'dhl2sbjo5';
  final String uploadPreset = 't_stores';

  /// Function to save user data to Firestore
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection('Users').doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Function to fetch userModels on Firebase
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Function to update user data in Firebase
  Future<void> updateUserRecord(UserModel updateUser) async {
    try {
      await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .set(updateUser.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Function to remove user data in Firebase
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection('Users').doc(userId).delete();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Update any field in specific Users Collection
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(json);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Upload any Images (now using Cloudinary). Nếu có oldImageUrl sẽ xóa ảnh cũ trước khi upload mới
  Future<String> uploadImage(
    String path,
    XFile image, {
    String? oldImageUrl,
  }) async {
    try {
      // Nếu có url ảnh cũ thì xóa trước
      if (oldImageUrl != null && oldImageUrl.isNotEmpty) {
        await deleteImageFromCloudinary(oldImageUrl);
      }
      final bytes = await image.readAsBytes();
      final url = await uploadImageToCloudinary(
        file: bytes,
        path: path,
        imageName: image.name,
      );
      return url;
    } catch (e) {
      throw 'Something went wrong. Please try again!.';
    }
  }

  /// Xóa ảnh trên Cloudinary bằng url
  Future<void> deleteImageFromCloudinary(String imageUrl) async {
    try {
      // Lấy public_id từ url ảnh
      final uri = Uri.parse(imageUrl);
      final segments = uri.pathSegments;
      // Tìm vị trí "upload/" và lấy phần sau nó làm public_id
      final uploadIndex = segments.indexOf('upload');
      if (uploadIndex == -1 || uploadIndex + 1 >= segments.length) return;
      segments
          .sublist(uploadIndex + 1)
          .join('/')
          .replaceAll('.jpg', '')
          .replaceAll('.png', '');

      // Gọi API xóa ảnh (cần API Key/Secret, demo chỉ log public_id)
      // Thực tế bạn cần backend hoặc cloud function để bảo mật API Key/Secret
    } catch (e) {
      throw e.toString();
    }
  }

  // Upload Images to Cloudinary, return url
  Future<String> uploadImageToCloudinary({
    required Uint8List file,
    required String path,
    required String imageName,
  }) async {
    try {
      final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
      );
      final response = await http.post(
        url,
        body: {
          'file': 'data:image/png;base64,${base64Encode(file)}',
          'upload_preset': uploadPreset,
          'public_id': '$path/$imageName'.replaceFirst(RegExp(r'^/'), ''),
        },
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return json['secure_url'] ?? json['url'] ?? '';
      } else {
        throw 'Upload error: [${response.statusCode}] ${response.body}';
      }
    } catch (e) {
      throw 'Lỗi khi upload Cloudinary: $e';
    }
  }
}
