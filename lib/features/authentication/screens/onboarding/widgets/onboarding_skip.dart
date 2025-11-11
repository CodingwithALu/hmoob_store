import 'package:flutter/material.dart';
import 'package:trip_store/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:trip_store/utils/constants/sizes.dart';
import 'package:trip_store/utils/devices/device_utility.dart';
import 'package:trip_store/l10n/app_localizations.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({super.key});
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Positioned(
      top: TDeviceUtils.getAppBarHeight(),
      right: TSizes.defaultSpace,
      child: TextButton(
        onPressed: () => OnBoardingController.instance.skiPage(),
        child: Text(localizations.skip),
      ),
    );
  }
}
