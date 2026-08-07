import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextPoppins extends StatelessWidget {
  const CustomTextPoppins({
    super.key,
    required this.text,
    required this.fontWeight,
    required this.fontSize,
    required this.color,
  });
  final String text;
  final FontWeight fontWeight;
  final double fontSize;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
