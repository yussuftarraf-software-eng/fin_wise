import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/my_colors.dart';

class CustomTextField extends FormField<String> {
  CustomTextField({
    super.key,
    required TextEditingController controller,
    required String hintText,
    bool isThereIcon = false,
    String? svgIcon,
    required bool obscureText,
    bool readOnly = false,
    Future<dynamic> Function()? onTap,
    required TextInputType textInputType,
    String? Function(String?)? validator,
  }) : super(
         // We ignore FormField's own `value` bookkeeping and always validate
         // against the controller's live text instead.
         validator: (_) => validator?.call(controller.text),
         autovalidateMode: AutovalidateMode.onUserInteraction,
         builder: (field) {
           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               // Fixed-size box: this NEVER resizes, error or not.
               Container(
                 width: 356,
                 height: 41,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(18),
                   color: myColors().lightGreen,
                   border: field.hasError
                       ? Border.all(color: Colors.redAccent, width: 1.2)
                       : null,
                 ),
                 child: TextFormField(
                   obscureText: obscureText,
                   controller: controller,
                   readOnly: readOnly,
                   onTap: onTap == null ? null : () => onTap(),
                   keyboardType: textInputType,
                   // Not `validator:` here — the outer FormField owns validation.
                   // This just keeps the FormField's error state fresh as you type.
                   onChanged: (value) => field.didChange(value),
                   enableSuggestions: false,
                   autocorrect: false,
                   textAlignVertical: TextAlignVertical.center,
                   style: GoogleFonts.poppins(
                     fontSize: 16,
                     color: myColors().lettersAndIcons,
                   ),
                   decoration: InputDecoration(
                     suffixIcon: svgIcon == null
                         ? null
                         : Padding(
                             padding: const EdgeInsets.only(right: 14),
                             child: SvgPicture.asset(
                               svgIcon,
                               width: 20,
                               height: 20,
                               color: myColors().darkModeGreenBar,
                             ),
                           ),
                     // No errorText/errorStyle here on purpose — we draw our
                     // own error text below instead of letting InputDecorator
                     // reserve space inside this fixed-height box.
                     isDense: true,
                     border: InputBorder.none,
                     hintText: hintText,
                     hintStyle: GoogleFonts.poppins(
                       fontSize: 16,
                       color: myColors().lettersAndIcons.withOpacity(0.45),
                     ),
                     contentPadding: const EdgeInsets.symmetric(
                       horizontal: 34,
                       vertical: 10,
                     ),
                   ),
                 ),
               ),
               // Error text lives OUTSIDE the box, so the box itself is stable.
               if (field.hasError)
                 Padding(
                   padding: const EdgeInsets.only(top: 4, left: 16),
                   child: Text(
                     field.errorText!,
                     style: GoogleFonts.poppins(
                       fontSize: 11,
                       color: Colors.redAccent,
                     ),
                   ),
                 ),
             ],
           );
         },
       );
}
