import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:hmoob_store/common/widgets/appbar/appbar.dart';
import 'package:hmoob_store/features/personalization/controllers/address_controller.dart';
import 'package:hmoob_store/utils/validators/validation.dart';
import 'package:hmoob_store/l10n/app_localizations.dart';

import '../../../../utils/constants/sizes.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // implement build
    final controller = AddressController.instance;
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(AppLocalizations.of(context)!.addNewAddressTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: controller.addressFormKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.name,
                  validator: (value) => TValidator.validateEmptyText(
                    AppLocalizations.of(context)!.addressNameLabel,
                    value,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.user),
                    labelText: AppLocalizations.of(context)!.addressNameLabel,
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(
                  controller: controller.phoneNumber,
                  validator: (value) => TValidator.validatePhoneNumber(value),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.mobile),
                    labelText: AppLocalizations.of(context)!.addressPhoneLabel,
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.street,
                        validator: (value) => TValidator.validateEmptyText(
                          AppLocalizations.of(context)!.addressStreetLabel,
                          value,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Iconsax.building_31),
                          labelText: AppLocalizations.of(
                            context,
                          )!.addressStreetLabel,
                        ),
                      ),
                    ),
                    const SizedBox(width: TSizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        controller: controller.postalCode,
                        validator: (value) => TValidator.validateEmptyText(
                          AppLocalizations.of(context)!.addressPostalCodeLabel,
                          value,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Iconsax.code),
                          labelText: AppLocalizations.of(
                            context,
                          )!.addressPostalCodeLabel,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.city,
                        validator: (value) => TValidator.validateEmptyText(
                          AppLocalizations.of(context)!.addressCityLabel,
                          value,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Iconsax.building),
                          labelText: AppLocalizations.of(
                            context,
                          )!.addressCityLabel,
                        ),
                      ),
                    ),
                    const SizedBox(width: TSizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        controller: controller.state,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Iconsax.activity),
                          labelText: AppLocalizations.of(
                            context,
                          )!.addressStateLabel,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(
                  controller: controller.country,
                  validator: (value) => TValidator.validateEmptyText(
                    AppLocalizations.of(context)!.addressCountryLabel,
                    value,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.global),
                    labelText: AppLocalizations.of(
                      context,
                    )!.addressCountryLabel,
                  ),
                ),
                const SizedBox(height: TSizes.defaultSpace),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.addNewAddress(),
                    child: Text(AppLocalizations.of(context)!.saveButton),
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
