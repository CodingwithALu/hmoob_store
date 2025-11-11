import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_store/features/authentication/controllers/signup/signup_controller.dart';
import 'package:trip_store/features/authentication/screens/signup/widgets/terms_condotions_checkbox.dart';
import 'package:trip_store/utils/validators/validation.dart';
import 'package:trip_store/l10n/app_localizations.dart';
import '../../../../../utils/constants/sizes.dart';

class TSignupFrom extends StatelessWidget {
  const TSignupFrom({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    final localizations = AppLocalizations.of(context)!;

    return Form(
      key: controller.signupFromKey,
      child: Column(
        children: [
          Row(
            /// Todo -- First & lastName
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) => TValidator.validateEmptyText(
                    localizations.firstName,
                    value,
                  ),
                  expands: false,
                  decoration: InputDecoration(
                    labelText: localizations.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              SizedBox(width: TSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) => TValidator.validateEmptyText(
                    localizations.lastName,
                    value,
                  ),
                  expands: false,
                  decoration: InputDecoration(
                    labelText: localizations.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// Username
          TextFormField(
            controller: controller.userName,
            validator: (value) =>
                TValidator.validateEmptyText(localizations.username, value),
            expands: false,
            decoration: InputDecoration(
              labelText: localizations.username,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          ///Email
          TextFormField(
            controller: controller.email,
            validator: (value) => TValidator.validateEmail(value),
            decoration: InputDecoration(
              labelText: localizations.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          ///Phone Number
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => TValidator.validatePhoneNumber(value),
            decoration: InputDecoration(
              labelText: localizations.phoneNo,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          ///Password
          Obx(
            () => TextFormField(
              controller: controller.password,
              validator: (value) => TValidator.validatePassword(value),
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                labelText: localizations.password,
                prefixIcon: Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: () => controller.hidePassword.value =
                      !controller.hidePassword.value,
                  icon: Icon(
                    controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwSections),

          ///Term&Conditions Checkbox
          const TTermAndConditionCheckbox(),
          const SizedBox(height: TSizes.spaceBtwSections),

          ///Signup Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: Text(localizations.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
