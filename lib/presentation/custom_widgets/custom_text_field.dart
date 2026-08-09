import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/my_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isThereIcon;
  final String? svgIcon;
  final bool obscureText;
  final bool readOnly;
  final Future<dynamic> Function()?
  onTap; // FIXED: made nullable so it can default to null instead of invalid `{}`

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isThereIcon = false,
    this.svgIcon,
    required this.obscureText,
    this.readOnly =
        false, // FIXED: added missing `this.` so it actually sets the field (defaults to false as requested)
    this.onTap, // FIXED: no assignment needed now — nullable defaults to null automatically (empty/no-op as requested)
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 356,
      height: 41,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: myColors().lightGreen,
      ),
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        readOnly:
            readOnly, // NEW: now actually wired up — was declared but unused before
        onTap: onTap == null
            ? null
            : () =>
                  onTap!(), // NEW: wraps your async onTap into the sync VoidCallback TextField expects
        keyboardType: TextInputType.emailAddress,
        enableSuggestions: false,
        autocorrect: false,
        // Align vertical center
        textAlignVertical: TextAlignVertical.center,
        style: GoogleFonts.poppins(
          fontSize: 16,
          color: myColors().lettersAndIcons,
        ),
        decoration: InputDecoration(
          suffixIcon: svgIcon == null
              ? null
              : Padding(
                  padding: EdgeInsetsGeometry.only(right: 14),
                  child: SvgPicture.asset(
                    svgIcon!,
                    width: 2,
                    height: 2,
                    color: myColors().darkModeGreenBar,
                  ),
                ),
          isDense: true, // Reduces default material height
          border: InputBorder.none,
          // Pass the hint string directly
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            fontSize: 16,
            color: myColors().lettersAndIcons.withOpacity(0.45),
          ),
          // Control padding cleanly here
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 34,
            vertical: 10, // Adjust slightly if needed to match font metrics
          ),
        ),
      ),
    );
  }
}
