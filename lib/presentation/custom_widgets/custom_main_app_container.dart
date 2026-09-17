import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/my_colors.dart';

class CustomMainAppContainer extends StatelessWidget {
  final double EdgeRaduis;
  final Color backgroundColor;
  final Widget child;
  final Color borderColor;
  final double borderWidth;
  const CustomMainAppContainer({
    super.key,
    required this.EdgeRaduis,
    required this.backgroundColor,
    required this.child,
    this.borderColor = Colors.black,
    this.borderWidth = 0.1,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(100),
            topRight: Radius.circular(100),
          ),
          border: Border.all(color: Colors.black, width: 0),
          color: myColors.backgroundGreenWhite,
        ),
        child: child,
      ),
    );
  }
}
