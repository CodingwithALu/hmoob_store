import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_store/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:trip_store/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:trip_store/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:trip_store/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:trip_store/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:trip_store/utils/constants/image_strings.dart';
import 'package:trip_store/l10n/app_localizations.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    final localizations = AppLocalizations.of(context)!;

    // implement build
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: [
              OnBoardingPage(
                image: TImages.onBoardingImage1,
                title: localizations.onBoardingTitle1,
                subTitle: localizations.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: TImages.onBoardingImage2,
                title: localizations.onBoardingTitle2,
                subTitle: localizations.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                image: TImages.onBoardingImage3,
                title: localizations.onBoardingTitle3,
                subTitle: localizations.onBoardingSubTitle3,
              ),
            ],
          ),
          const OnBoardingSkip(),
          const OnBoardingDotNavigation(),
          const OnBoardingNextButton(),
        ],
      ),
    );
  }
}
