import 'package:flutter/material.dart';
import 'package:trip_store/common/widgets/appbar/appbar.dart';
import 'package:trip_store/features/shop/screens/order/widgets/order_list.dart';
import 'package:trip_store/l10n/app_localizations.dart';
import 'package:trip_store/utils/constants/sizes.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    // implement build
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          localizations.myOrder,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: TOrderListItems(),
      ),
    );
  }
}
