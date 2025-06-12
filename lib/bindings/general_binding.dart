// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/utils/helpers/network_manager.dart';
class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(NetworkManager());

  }

}