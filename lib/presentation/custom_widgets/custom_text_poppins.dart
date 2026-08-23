import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextPoppins extends StatelessWidget {
  const CustomTextPoppins({
    super.key,
    required this.text,
    required this.fontWeight,
    required this.fontSize,
    required this.color,
    this.maxLines = 1,
  });
  final String text;
  final FontWeight fontWeight;
  final double fontSize;
  final Color color;
  final int maxLines;
  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: maxLines,
      text,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
