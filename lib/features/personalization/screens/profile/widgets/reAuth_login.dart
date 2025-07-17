// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/features/personalization/controllers/user_controller.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/l10n/app_localizations.dart';
import 'package:t_store/utils/validators/validation.dart';
import '../../../../../utils/constants/text_string.dart';

class ReAuthLoginScreen extends StatelessWidget {
  const ReAuthLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    // implement build
    return Scaffold(
      appBar: TAppBar(
        title: Text(AppLocalizations.of(context)!.reAuthTitle),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: controller.reAuthFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: controller.verifyEmail,
                  validator: TValidator.validateEmail,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.direct_right),
                    labelText: TTexts.email,
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                Obx(
                  () => TextFormField(
                    obscureText: controller.hidePassword.value,
                    controller: controller.verifyPassword,
                    validator: (value) =>
                        TValidator.validateEmptyText('Password', value),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Iconsax.password_check),
                      labelText: TTexts.password,
                      suffixIcon: IconButton(
                        onPressed: () => controller.hidePassword.value =
                            !controller.hidePassword.value,
                        icon: const Icon(Iconsax.eye_slash),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () =>
                        controller.reAuthenticateEmailAndPasswordUser(),
                    child: Text(AppLocalizations.of(context)!.verifyButton),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
