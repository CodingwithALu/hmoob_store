import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_store/features/authentication/controllers/forget_password/forget_controller.dart';
import 'package:trip_store/features/authentication/screens/login/login.dart';
import 'package:trip_store/utils/constants/image_strings.dart';
import 'package:trip_store/utils/helpers/helper_functions.dart';
import 'package:trip_store/l10n/app_localizations.dart';
import '../../../../utils/constants/sizes.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key, required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    // implement build
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(CupertinoIcons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Image with 600% of screen width
              Image(
                image: const AssetImage(TImages.deliveredEmailIllustration),
                width: THelperFunctions.screenWidth() * 0.6,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Title & Subtitle
              Text(
                email,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(
                localizations.changeYourPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(
                localizations.changeYourPasswordSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.offAll(() => const LoginScreen()),
                  child: Text(localizations.done),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => ForgetPasswordController.instance
                      .resendPassWordResetEmail(email),
                  child: Text(localizations.resendEmail),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
