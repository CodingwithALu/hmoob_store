import 'package:flutter/material.dart';
import 'package:hmoob_store/l10n/app_localizations.dart';
import 'package:hmoob_store/utils/constants/image_strings.dart';
import 'package:hmoob_store/utils/constants/sizes.dart';
import 'package:hmoob_store/utils/helpers/helper_functions.dart';

class TLoginHeader extends StatelessWidget {
  const TLoginHeader({super.key});
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final local = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          height: 150,
          image: AssetImage(dark ? TImages.hmoobLogos : TImages.hmoobLogos),
        ),
        Text(
          local.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: TSizes.sm),
        Text(
          local.loginSubTitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
