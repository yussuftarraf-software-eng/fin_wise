import 'dart:math';
import 'package:fin_wise/presentation/custom_widgets/custom_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/my_colors.dart';
import '../../../domain/functions/validation_functions.dart';
import '../../custom_widgets/custom_main_app_container.dart';
import '../../custom_widgets/custom_text_form_field.dart';
import '../../custom_widgets/custom_text_poppins.dart';

class LoginInScreen extends StatefulWidget {
  const LoginInScreen({super.key});

  @override
  State<LoginInScreen> createState() => _LoginInScreenState();
}

class _LoginInScreenState extends State<LoginInScreen> {
  late final TapGestureRecognizer _fingerprintRecognizer;
  late final TapGestureRecognizer _signUpRecognizer;
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _fingerprintRecognizer = TapGestureRecognizer()
      ..onTap = () {
        //Todo: add fingerprint functionality of firebase
        print('Fingerprint tapped');
      };
    _signUpRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pushNamed(context, '/SignUp');
      };
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: myColors().mainGreen,
        body: Center(
          child: Column(
            children: [
              Gap(100),
              CustomTextPoppins(
                text: "Welcome",
                fontWeight: .w600,
                fontSize: 30,
                color: myColors().lettersAndIcons,
              ),
              Gap(65),
              CustomMainAppContainer(
                EdgeRaduis: 100,
                backgroundColor: myColors().backgroundGreenWhite,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Gap(90),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: CustomTextPoppins(
                          text: "Username Or Email",
                          fontWeight: .w600,
                          fontSize: 15,
                          color: myColors().lettersAndIcons,
                        ),
                      ),
                      Gap(8),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            //user email field
                            CustomTextField(
                              controller: emailController,
                              hintText: 'example@example.com',
                              obscureText: false,
                              textInputType: TextInputType.emailAddress,
                              validator: ValidationFunctions.validateEmail,
                            ),
                            Gap(23),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: CustomTextPoppins(
                                text: "Password",
                                fontSize: 15,
                                fontWeight: .w600,
                                color: myColors().lettersAndIcons,
                              ),
                            ),
                            Gap(3),
                            //user password field
                            CustomTextField(
                              controller: passwordController,
                              hintText: "● ● ● ● ● ● ● ● ● ",
                              isThereIcon: true,
                              svgIcon: 'assets/svgs/Eye-Pass.svg',
                              obscureText: true,
                              textInputType: TextInputType.number,
                              validator: ValidationFunctions.validatePassword,
                            ),
                          ],
                        ),
                      ),

                      Gap(91),
                      Center(
                        child: Column(
                          children: [
                            //login button
                            CustomButton(
                              onTap: () {
                                // validate() itself already triggers a rebuild
                                // of each field's error state — no setState needed here.
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Processing Data'),
                                    ),
                                  );
                                }
                              },
                              text: "Log in ",
                              width: 207,
                              height: 45,
                              backgroundColor: myColors().mainGreen,
                              textColor: myColors().lettersAndIcons,
                            ),
                            Gap(19),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/ForgotPassword');
                              },
                              child: Text(
                                "Forgot Password?",
                                style: GoogleFonts.leagueSpartan(
                                  fontWeight: .w600,
                                  fontSize: 14,
                                  color: myColors().lettersAndIcons,
                                ),
                              ),
                            ),
                            Gap(14),
                            //sign up button
                            CustomButton(
                              onTap: () {
                                Navigator.pushNamed(context, '/SignUp');
                              },

                              text: "Sign Up",
                              width: 207,
                              height: 45,
                              backgroundColor: myColors().lightGreen,
                              textColor: myColors().darkModeGreenBar,
                            ),
                            Gap(23),
                            Text.rich(
                              TextSpan(
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: myColors()
                                      .darkModeGreenBar, // default style for the whole line
                                ),
                                children: [
                                  const TextSpan(text: 'Use '),
                                  TextSpan(
                                    recognizer: _fingerprintRecognizer,
                                    text: 'Fingerprint',
                                    style: GoogleFonts.poppins(
                                      color: myColors().oceanBlueButton,
                                    ), // just override color
                                  ),
                                  const TextSpan(text: ' To Access'),
                                ],
                              ),
                            ),
                            Gap(28),
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
                                SvgPicture.asset(
                                  "assets/svgs/Facebook.svg",
                                  color: myColors().darkModeGreenBar,
                                ),
                                Gap(17),
                                SvgPicture.asset(
                                  "assets/svgs/Google.svg",
                                  color: myColors().darkModeGreenBar,
                                ),
                              ],
                            ),
                            Gap(20),
                            Text.rich(
                              TextSpan(
                                style: GoogleFonts.leagueSpartan(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                  color: myColors()
                                      .lettersAndIcons, // default style for the whole line
                                ),
                                children: [
                                  const TextSpan(
                                    text: "Don't have an account?",
                                  ),
                                  TextSpan(
                                    recognizer: _signUpRecognizer,
                                    text: 'Sign up',
                                    style: GoogleFonts.poppins(
                                      color: myColors().blueButton,
                                    ), // just override color
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
