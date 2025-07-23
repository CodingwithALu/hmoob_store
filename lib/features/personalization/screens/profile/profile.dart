import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_store/common/widgets/appbar/appbar.dart';
import 'package:trip_store/common/widgets/images/t_circular_image.dart';
import 'package:trip_store/common/widgets/shimmer/shimmer.dart';
import 'package:trip_store/common/widgets/texts/section_heading.dart';
import 'package:trip_store/features/personalization/controllers/user_controller.dart';
import 'package:trip_store/features/personalization/screens/profile/widgets/change_name_users.dart';
import 'package:trip_store/features/personalization/screens/profile/widgets/t_profile_menu.dart';
import 'package:trip_store/l10n/app_localizations.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // implement build
    final controller = UserController.instance;
    final local = AppLocalizations.of(context)!;
    return Scaffold(
      /// AppBar
      appBar: TAppBar(title: Text(local.profile), showBackArrow: true),

      /// Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Profile picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final networkImage = controller.user.value.profilePicture;
                      final image = networkImage.isNotEmpty
                          ? networkImage
                          : TImages.user;
                      return controller.imageUploading.value
                          ? const TShimmerEffect(
                              width: 80,
                              height: 80,
                              radius: 80,
                            )
                          : TCircularImage(
                              image: image,
                              width: 80,
                              height: 80,
                              isNetworkImage: networkImage.isNotEmpty,
                            );
                    }),
                    TextButton(
                      onPressed: () => controller.uploadUseProfilePicture(),
                      child: Text(local.changeProfilePicture),
                    ),
                  ],
                ),
              ),

              /// Details
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              TSectionHeading(
                title: local.profileInformation,
                showActionButton: false,
              ),
              TProfileMenu(
                title: local.name,
                value: controller.user.value.fullName,
                onPressed: () => Get.to(() => const ChangeName()),
              ),
              TProfileMenu(
                title: local.username,
                value: controller.user.value.lastName,
                onPressed: () {},
              ),

              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Heading Personal Info
              TSectionHeading(
                title: local.personalInformation,
                showActionButton: false,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              TProfileMenu(
                onPressed: () {},
                title: local.userId,
                value: controller.user.value.id,
                icon: Iconsax.copy,
              ),
              TProfileMenu(
                onPressed: () {},
                title: local.email,
                value: controller.user.value.email,
              ),
              TProfileMenu(
                onPressed: () {},
                title: local.phoneNumber,
                value: controller.user.value.phoneNumber,
              ),
              TProfileMenu(
                onPressed: () {},
                title: local.gender,
                value: 'Male',
              ),
              TProfileMenu(
                onPressed: () {},
                title: local.dateOfBirth,
                value: '10 Oct 2003',
              ),

              /// Footer
              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              Center(
                child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: Text(
                    local.closeAccount,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
