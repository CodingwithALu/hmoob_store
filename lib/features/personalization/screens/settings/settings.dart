import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/custom_shapes/container/primary_header_container.dart';
import 'package:t_store/common/widgets/list_titles/setting_menu_title.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/authentication/screens/login/login.dart';
import 'package:t_store/features/personalization/screens/address/address.dart';
import 'package:t_store/l10n/app_localizations.dart';

import '../../../../common/widgets/list_titles/user_profile_title.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../shop/screens/order/order.dart';
import '../profile/profile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // implement build
    final local = AppLocalizations.of(context)!;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  ///AppBar
                  TAppBar(
                    title: Text(
                      local.account,
                      style: Theme.of(
                        context,
                      ).textTheme.headlineMedium!.apply(color: TColors.white),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// User Profile Card
                  TUserProfileTitle(
                    onPressed: () => Get.to(() => const ProfileScreen()),
                  ),

                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

            /// Body
            Padding(
              padding: const EdgeInsets.all(TSizes.spaceBtwSections),
              child: Column(
                children: [
                  /// Account Settings
                  TSectionHeading(
                    title: local.accountSetting,
                    showActionButton: false,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  TSettingsMenuTitle(
                    icon: Iconsax.safe_home,
                    title: local.myAddress,
                    subTitle: local.myAddressSub,
                    onTap: () => Get.to(() => const UserAddressScreen()),
                  ),
                  TSettingsMenuTitle(
                    icon: Iconsax.shopping_cart,
                    title: local.myCart,
                    subTitle: local.myCartSub,
                    onTap: () {},
                  ),
                  TSettingsMenuTitle(
                    icon: Iconsax.bag_tick,
                    title: local.myOrders,
                    subTitle: local.myOrdersSub,
                    onTap: () => Get.to(() => const OrderScreen()),
                  ),
                  TSettingsMenuTitle(
                    icon: Iconsax.bank,
                    title: local.bankAccount,
                    subTitle: local.bankAccountSub,
                    onTap: () {},
                  ),
                  TSettingsMenuTitle(
                    icon: Iconsax.discount_shape,
                    title: local.myCoupons,
                    subTitle: local.myCouponsSub,
                    onTap: () {},
                  ),
                  TSettingsMenuTitle(
                    icon: Iconsax.notification,
                    title: local.notifications,
                    subTitle: local.notificationsSub,
                    onTap: () {},
                  ),
                  TSettingsMenuTitle(
                    icon: Iconsax.security_card,
                    title: local.accountPrivacy,
                    subTitle: local.accountPrivacySub,
                    onTap: () {},
                  ),

                  /// App Settings
                  const SizedBox(height: TSizes.spaceBtwSections),
                  TSectionHeading(
                    title: local.appSettings,
                    showActionButton: false,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  TSettingsMenuTitle(
                    icon: Iconsax.document_upload,
                    title: local.loadData,
                    subTitle: local.loadDataSub,
                  ),
                  TSettingsMenuTitle(
                    icon: Iconsax.location,
                    title: local.geolocation,
                    subTitle: local.geolocationSub,
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  TSettingsMenuTitle(
                    icon: Iconsax.security_user,
                    title: local.safeMode,
                    subTitle: local.safeModeSub,
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  TSettingsMenuTitle(
                    icon: Iconsax.image,
                    title: local.hdImageQuality,
                    subTitle: local.hdImageQualitySub,
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),

                  /// Logout Button
                  const SizedBox(height: TSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => Get.to(() => const LoginScreen()),
                      child: Text(local.logout),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections * 2.5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
