import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';
import '../../../../../common/widgets/custom_shapes/container/rounded_container.dart';
import '../../../../../utils/constants/sizes.dart';
class TSingleAddress extends StatelessWidget {
  const TSingleAddress({
    super.key, required this.selectedAddress,
  });
  final bool selectedAddress;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TRoundedContainer(
      padding: EdgeInsets.all(TSizes.md),
      width: double.infinity,
      showBorder: true,
      backgroundColor: selectedAddress ? TColors.primary.withAlpha(128) : Colors.transparent,
      borderColor: selectedAddress ? Colors.transparent : dark ? TColors.darkerGrey : TColors.grey,
      margin: const  EdgeInsets.only(bottom: TSizes.spaceBtwItems),
      child: Stack(
        children: [
          Positioned(
            right: 5,
            top: 0,
            child: Icon(selectedAddress ? Iconsax.tick_circle5 : null,
            color: selectedAddress ? dark ? TColors.light : TColors.dark.withAlpha(135) : null,),
          ),
          
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Josh Doe',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge,),
              const SizedBox(height: TSizes.sm /2,),
              const Text('(+123) 456 7890', maxLines: 1, overflow: TextOverflow.ellipsis,),
              const SizedBox(height: TSizes.md/2,),
              const Text('82356 Timmy Coves, South Liana, Maine, 87665, USA', softWrap: true,)
            ],

          )
        ],
      ),
    );
  }
}