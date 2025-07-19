import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:hmoob_store/common/widgets/appbar/appbar.dart';
import 'package:hmoob_store/features/personalization/controllers/address_controller.dart';
import 'package:hmoob_store/features/personalization/screens/address/add_new_address.dart';
import 'package:hmoob_store/features/personalization/screens/address/widgets/single_address.dart';
import 'package:hmoob_store/l10n/app_localizations.dart';
import 'package:hmoob_store/utils/helpers/cloud_helper_functions.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // implement build
    final controller = AddressController.instance;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: TColors.primary,
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        child: const Icon(Iconsax.add, color: TColors.white),
      ),
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          AppLocalizations.of(context)!.addressesTitle,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Obx(
            () => FutureBuilder(
              key: Key(controller.refreshData.value.toString()),
              future: controller.getAllUserAddresses(),
              builder: (context, snapshot) {
                final reponse = TCloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot,
                );
                if (reponse != null) return reponse;

                final address = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: address.length,
                  itemBuilder: (_, index) => TSingleAddress(
                    address: address[index],
                    onTap: () => controller.selectAddress(address[index]),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
