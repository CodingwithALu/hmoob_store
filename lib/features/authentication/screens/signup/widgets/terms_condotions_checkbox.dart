import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_store/features/authentication/controllers/signup/signup_controller.dart';
import 'package:trip_store/l10n/app_localizations.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class TTermAndConditionCheckbox extends StatelessWidget {
  const TTermAndConditionCheckbox({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    final dark = THelperFunctions.isDarkMode(context);
    final localizations = AppLocalizations.of(context)!;

    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Obx(
            () => Checkbox(
              value: controller.privacyPolicy.value,
              onChanged: (value) => controller.privacyPolicy.value =
                  !controller.privacyPolicy.value,
            ),
          ),
        ),
        const SizedBox(width: TSizes.spaceBtwItems),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${localizations.iAgreeTo} ',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                TextSpan(
                  text: '${localizations.privacyPolicy} ',
                  style: Theme.of(context).textTheme.labelSmall!.apply(
                    color: dark ? TColors.white : TColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: dark ? TColors.white : TColors.primary,
                  ),
                ),
                TextSpan(
                  text: '${localizations.and} ',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                TextSpan(
                  text: '${localizations.termsOfUse} ',
                  style: Theme.of(context).textTheme.labelSmall!.apply(
                    color: dark ? TColors.white : TColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: dark ? TColors.white : TColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
