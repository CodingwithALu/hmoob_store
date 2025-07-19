import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hmoob_store/bindings/general_binding.dart';
import 'package:hmoob_store/l10n/app_localizations.dart';
import 'package:hmoob_store/routes/app_routers.dart';
import 'package:hmoob_store/utils/constants/colors.dart';
import 'package:hmoob_store/utils/constants/text_string.dart';
import 'package:hmoob_store/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: TTexts.appName,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      debugShowCheckedModeBanner: false,

      /// Show Loader or Circular
      home: const Scaffold(
        backgroundColor: TColors.primary,
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      ),
      getPages: AppRoutes.pages,
      // i18n
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('vi'),
    );
  }
}
