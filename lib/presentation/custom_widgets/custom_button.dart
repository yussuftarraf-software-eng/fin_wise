import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/my_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final double radius;
  final Color backgroundColor;
  final Color textColor;
  final Function? onTap;
  final FontWeight? fontWeight;
  final double? fontSize;
  const CustomButton({
    super.key,
    required this.text,
    required this.width,
    required this.height,
    this.radius = 20,
    required this.backgroundColor,
    required this.textColor,
    this.onTap,
    this.fontWeight = FontWeight.w600,
    this.fontSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        onPressed: () {
          onTap!();
        },
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
