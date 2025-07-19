import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:hmoob_store/features/personalization/screens/settings/settings.dart';
import 'package:hmoob_store/features/shop/screens/home/home.dart';
import 'package:hmoob_store/features/shop/screens/store/store.dart';
import 'package:hmoob_store/features/shop/screens/wishlist/wishlist.dart';
import 'package:hmoob_store/l10n/app_localizations.dart';
import 'package:hmoob_store/utils/constants/colors.dart';
import 'package:hmoob_store/utils/helpers/helper_functions.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = THelperFunctions.isDarkMode(context);
    final local = AppLocalizations.of(context)!;
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          backgroundColor: darkMode ? TColors.black : TColors.white,
          indicatorColor: darkMode
              ? TColors.white.withAlpha((0.1 * 255).round())
              : TColors.black.withAlpha((0.1 * 255).round()),
          destinations: [
            NavigationDestination(icon: Icon(Iconsax.home), label: local.home),
            NavigationDestination(icon: Icon(Iconsax.shop), label: local.store),
            NavigationDestination(
              icon: Icon(Iconsax.heart),
              label: local.wishlist,
            ),
            NavigationDestination(
              icon: Icon(Iconsax.user),
              label: local.profile,
            ),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    const HomeScreen(),
    const StoreScreen(),
    const FavouriteScreen(),
    const SettingsScreen(),
  ];
}
