import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_string.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers/profile_controller/update_name_controller.dart';
class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    // TODO: implement build
    return Scaffold(
      appBar: TAppBar(title: Text('Change Name', style: Theme.of(context).textTheme.headlineSmall,), showBackArrow: true,),
      body: Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Headings
            Text('user real name for easy verifications. This name will appear on several pages',
              style: Theme.of(context).textTheme.labelMedium,),
            const SizedBox(height: TSizes.spaceBtwSections,),
            /// Texts field and button
            Form(
              key: controller.updateUserNameFormKey,
              child: Column(
                children: [
                  TextFormField(
                      controller: controller.firstname,
                      validator: (value) => TValidator.validateEmptyText(TTexts.firstName, value),
                      expands: false,
                      decoration: const InputDecoration(labelText: TTexts.firstName, prefixIcon: Icon(Iconsax.user))),
                  const SizedBox(height: TSizes.spaceBtwInputFields,),
                  TextFormField(
                    controller: controller.lastname,
                    validator: (value) => TValidator.validateEmptyText(TTexts.lastName, value),
                    expands: false,
                    decoration: const InputDecoration(labelText: TTexts.lastName, prefixIcon: Icon(Iconsax.user)),
                  )
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () => controller.updateUserName(), child: Text('Save')),
            )
          ],
        ),
      ),
    );
  }
}