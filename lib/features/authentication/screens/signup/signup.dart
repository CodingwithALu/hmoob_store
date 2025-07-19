import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hmoob_store/common/widgets/login_signup/social_buttons.dart';
import 'package:hmoob_store/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:hmoob_store/utils/constants/sizes.dart';
import 'package:hmoob_store/utils/constants/text_string.dart';
import '../../../../common/widgets/login_signup/from_divider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // implement build
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Text(
                TTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// From
              TSignupFrom(),
              const SizedBox(height: TSizes.spaceBtwSections),

              ///Divider
              TFromDivider(dividerText: TTexts.orSignInWith.capitalize!),
              const SizedBox(height: TSizes.spaceBtwSections),

              ///Social Buttons
              const TSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
