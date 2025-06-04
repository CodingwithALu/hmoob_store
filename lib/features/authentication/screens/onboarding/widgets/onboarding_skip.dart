import 'package:flutter/material.dart';
import 'package:t_store/features/authentication/controllers/onboarding_controller.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/devices/device_utility.dart';
class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: TDeviceUtils.getAppBarHeight(),
      right: TSizes.defaultSpace,
      child: TextButton(onPressed: () => OnBoardingController.instance.skiPage(), child: const Text('Skip')),
    );
  }
}
