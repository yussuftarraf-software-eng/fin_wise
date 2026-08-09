import 'package:fin_wise/constants/my_colors.dart';
import 'package:fin_wise/presentation/custom_widgets/custom_button.dart';
import 'package:fin_wise/route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../custom_widgets/custom_main_app_container.dart';
import '../custom_widgets/custom_text_field.dart';
import '../custom_widgets/custom_text_poppins.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: myColors().mainGreen,
        body: Center(
          child: Column(
            children: [
              Gap(100),
              CustomTextPoppins(
                text: "Forgot Password",
                fontWeight: .w600,
                fontSize: 30,
                color: myColors().lettersAndIcons,
              ),
              Gap(65),
              CustomMainAppContainer(
                EdgeRaduis: 100,
                backgroundColor: myColors().backgroundDarkModeAndLetters,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 37),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Gap(90),
                      CustomTextPoppins(
                        text: "Reset Password?",
                        fontWeight: .w600,
                        fontSize: 20,
                        color: myColors().darkModeGreenBar,
                      ),
                      Gap(14),
                      Center(
                        child: Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
                          style: GoogleFonts.leagueSpartan(
                            color: myColors().darkModeGreenBar,
                            wordSpacing: 0.01,
                          ),
                        ),
                      ),
                      Gap(82),
                      CustomTextPoppins(
                        text: "Enter Email Address",
                        fontWeight: .w600,
                        fontSize: 15,
                        color: myColors().lettersAndIcons,
                      ),
                      Gap(8),
                      CustomTextField(
                        controller: emailController,
                        hintText: 'example@example.com',
                        obscureText: false,
                      ),
                      Gap(45),
                      Center(
                        child: Column(
                          children: [
                            Center(
                              child: CustomButton(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.newPassword,
                                  );
                                },
                                text: 'Next Step',
                                width: 169,
                                height: 32,
                                backgroundColor: myColors().mainGreen,
                                textColor: myColors().lettersAndIcons,
                              ),
                            ),
                            Gap(25),
                            CustomButton(
                              onTap: () {
                                Navigator.pushNamed(context, AppRoutes.signUp);
                              },
                              text: "Sign Up",
                              width: 169,
                              height: 32,
                              backgroundColor: myColors().lightGreen,
                              textColor: myColors().darkModeGreenBar,
                            ),
                            Gap(18),
                            Text(
                              "or sign up with",
                              style: GoogleFonts.leagueSpartan(
                                fontSize: 13,
                                fontWeight: .w300,
                                color: myColors().lettersAndIcons,
                              ),
                            ),
                            Gap(19),
                            Row(
                              mainAxisAlignment: .center,
                              children: [
                                SvgPicture.asset("assets/svgs/Facebook.svg"),
                                Gap(17),
                                SvgPicture.asset("assets/svgs/Google.svg"),
                              ],
                            ),
                            Gap(20),
                            Text.rich(
                              TextSpan(
                                text: "Don't have an account? ",
                                style: GoogleFonts.leagueSpartan(
                                  color: myColors().lettersAndIcons,
                                  fontSize: 13,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Sign Up",
                                    style: GoogleFonts.leagueSpartan(
                                      color: myColors()
                                          .blueButton, // or whatever blue you're using
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushNamed(
                                          context,
                                          AppRoutes.signUp,
                                        );
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
