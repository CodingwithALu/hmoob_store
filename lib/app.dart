import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:t_store/navigation_menu.dart';
import 'package:t_store/utils/constants/text_string.dart';
import 'package:t_store/utils/theme/theme.dart';
import 'features/authentication/screens/onboarding/onboarding.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: TTexts.appName,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const OnBoardingScreen(),
      getPages: [
        GetPage(name: '/NavigationMenu', page: () => NavigationMenu()),
      ],
    );
  }
}
