import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:t_store/featrues/authentication/screens/onboarding.dart';
import 'package:t_store/utils/constants/text_string.dart';
import 'package:t_store/utils/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class App extends StatelessWidget {
  const App({super.key});
  static final Uri _productUri = Uri.parse('https://codingwitht.com/ecommerce-app-with-admin-panel/');
  Future<void> _launchProductLink() async {
    if (!await launchUrl(_productUri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $_productUri');
    }
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: TTexts.appName,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const OnBoardingScreen()
    );
  }
}