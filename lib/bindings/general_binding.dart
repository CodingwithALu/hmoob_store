// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/utils/helpers/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  // ignore: void_checks
  void dependencies() => Get.put(NetworkManager());
}
