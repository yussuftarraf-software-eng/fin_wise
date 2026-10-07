import 'package:fin_wise/presentation/custom_widgets/custom_text_poppins.dart';
import 'package:flutter/material.dart';

import '../../constants/my_colors.dart';

class CustomSwitchRow extends StatelessWidget {
  const CustomSwitchRow({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.fontSize = 15,
    this.fontWeight = FontWeight.w500,
    this.labelColor,
    this.activeTrackColor,
    this.thumbColor = Colors.white,
  });

  final String label;
  final bool value;
  final ValueChanged<bool>? onChanged;

  final double fontSize;
  final FontWeight fontWeight;
  final Color? labelColor;
  final Color? activeTrackColor;
  final Color thumbColor;

  @override
  Widget build(BuildContext context) {
    final trackColor = activeTrackColor ?? myColors.mainGreen;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTextPoppins(
          text: label,
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: labelColor ?? myColors.lettersAndIcons,
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          activeThumbColor: thumbColor,
          activeTrackColor: trackColor,
          inactiveThumbColor: thumbColor,
          inactiveTrackColor: trackColor.withValues(alpha: 0.5),
          trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
        ),
      ],
    );
  }
}
