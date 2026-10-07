import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../constants/my_colors.dart';
import 'custom_text_poppins.dart';

class CustomProfileRowElement extends StatelessWidget {
  final String image;
  final String text;
  VoidCallback? function;
  CustomProfileRowElement({
    super.key,
    required this.image,
    required this.text,
    this.function,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Row(
        children: [
          SvgPicture.asset(image),
          Gap(13),
          CustomTextPoppins(
            text: text,
            fontWeight: .w600,
            fontSize: 15,
            color: myColors.lettersAndIcons,
          ),
        ],
      ),
    );
  }
}
