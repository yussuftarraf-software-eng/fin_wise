import 'package:fin_wise/constants/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../custom_widgets/custom_main_app_container.dart';
import '../custom_widgets/custom_text_field.dart';
import '../custom_widgets/custom_text_poppins.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColors().mainGreen,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Center(
          child: Column(
            children: [
              Gap(100),
              CustomTextPoppins(
                text: "Create Account",
                fontWeight: .w600,
                fontSize: 30,
                color: myColors().lettersAndIcons,
              ),
              Gap(65),
              CustomMainAppContainer(
                EdgeRaduis: 100,
                backgroundColor: myColors().backgroundDarkModeAndLetters,
                child: Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 37),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Gap(27),
                      Padding(
                        padding: EdgeInsetsGeometry.only(left: 18),
                        child: CustomTextPoppins(
                          text: "Full Name",
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: myColors().lettersAndIcons,
                        ),
                      ),
                      Gap(3),
                      CustomTextField(
                        controller: fullNameController,
                        hintText: 'Jeff Nippard',
                        obscureText: false,
                      ),
                      Gap(16),
                      CustomTextPoppins(
                        text: "Email",
                        fontWeight: .w600,
                        fontSize: 15,
                        color: myColors().lettersAndIcons,
                      ),
                      Gap(3),
                      CustomTextField(
                        controller: emailController,
                        hintText: 'example@example.com',
                        obscureText: false,
                      ),
                      Gap(16),
                      CustomTextPoppins(
                        text: "Mobile Number",
                        fontWeight: .w600,
                        fontSize: 15,
                        color: myColors().lettersAndIcons,
                      ),
                      Gap(3),
                      // CustomTextField(
                      //   controller: controller,
                      //   hintText: hintText,
                      //   obscureText: obscureText,
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
