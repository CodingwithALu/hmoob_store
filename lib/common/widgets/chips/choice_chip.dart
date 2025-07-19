import 'package:flutter/material.dart';
import 'package:hmoob_store/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:hmoob_store/utils/helpers/helper_functions.dart';

import '../../../utils/constants/colors.dart';

class TChoiceChip extends StatelessWidget {
  const TChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final isColors = THelperFunctions.getColor(text) != null;
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        label: isColors ? const SizedBox() : Text(text),
        selected: selected,
        onSelected: onSelected,
        labelStyle: TextStyle(color: selected ? TColors.white : null),
        avatar: isColors
            ? TCircularContainer(
                width: 50,
                height: 50,
                backgroundColor: THelperFunctions.getColor(text)!,
              )
            : null,
        shape: isColors ? const CircleBorder() : null,
        labelPadding: isColors ? EdgeInsets.all(0) : null,
        padding: isColors ? EdgeInsets.all(0) : null,
        backgroundColor: THelperFunctions.getColor(text),
      ),
    );
  }
}
