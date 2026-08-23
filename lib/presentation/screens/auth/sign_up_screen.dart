import 'package:fin_wise/constants/my_colors.dart';
import 'package:fin_wise/data/repository/auth_implementaion.dart';
import 'package:fin_wise/data/web_services/dio_consumer.dart';
import 'package:fin_wise/domain/functions/validation_functions.dart';
import 'package:fin_wise/route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/model/user_model.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_main_app_container.dart';
import '../../custom_widgets/custom_text_form_field.dart';
import '../../custom_widgets/custom_text_poppins.dart';

class SignUpScreen extends StatefulWidget {
  // CHANGED: StatelessWidget -> StatefulWidget
  // Needed because picking a date is async (await showDatePicker) and must
  // trigger setState to update the field and rebuild the UI.
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController dateOfBirthController =
      TextEditingController(); // NEW: was referenced but never declared before
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  late TapGestureRecognizer _logInRecognizer = TapGestureRecognizer();

  // NEW: opens the native date picker and forces a valid date into the field.
  // Because the field is readOnly, this is the ONLY way the user can set a value —
  // no free typing, so no invalid/malformed dates are possible.
  Future<void> _pickDateOfBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(), // prevents picking a future birth date
    );

    if (picked != null) {
      setState(() {
        dateOfBirthController.text =
            "${picked.day.toString().padLeft(2, '0')} / "
            "${picked.month.toString().padLeft(2, '0')} / "
            "${picked.year}";
      });
    }
  }

  Future<dynamic> signUp() async {
    final response = await AuthImplementation(DioConsumer()).signUp(
      UserModelSignUp(
        firstName: fullNameController.text,
        lastName: emailController.text,
        age: 20,
      ),
    );
    print("${response.firstName} ${response.lastName} ${response.age}");
    Navigator.pushNamed(context, AppRoutes.homeScreen);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _logInRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pushNamed(context, '/LoginScreen');
      };
  }

  @override
  void dispose() {
    // NEW: dispose controllers to avoid memory leaks now that this is a State class
    fullNameController.dispose();
    emailController.dispose();
    mobileNumberController.dispose();
    dateOfBirthController.dispose();
    super.dispose();
  }

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
                      //choose phone number
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
                      Form(
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            CustomTextField(
                              controller: fullNameController,
                              hintText: 'Jeff Nippard',
                              obscureText: false,
                              textInputType: TextInputType.name,
                              validator: ValidationFunctions.validateFullName,
                            ),
                            Gap(16),
                            //choose email
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: CustomTextPoppins(
                                text: "Email",
                                fontWeight: .w600,
                                fontSize: 15,
                                color: myColors().lettersAndIcons,
                              ),
                            ),
                            Gap(3),
                            CustomTextField(
                              controller: emailController,
                              hintText: 'example@example.com',
                              obscureText: false,
                              textInputType: TextInputType.emailAddress,
                              validator: ValidationFunctions.validateEmail,
                            ),
                            Gap(16),
                            //choose phone number
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: CustomTextPoppins(
                                text: "Mobile Number",
                                fontWeight: .w600,
                                fontSize: 15,
                                color: myColors().lettersAndIcons,
                              ),
                            ),
                            Gap(3),
                            CustomTextField(
                              controller: mobileNumberController,
                              hintText: "+251912345678",
                              obscureText: false,
                              textInputType: TextInputType.phone,
                              validator:
                                  ValidationFunctions.validateMobileNumber,
                            ),
                            Gap(16),
                            //choose date of birth
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: CustomTextPoppins(
                                text: "Date of Birth",
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: myColors().lettersAndIcons,
                              ),
                            ),
                            Gap(3),
                            CustomTextField(
                              controller: dateOfBirthController,
                              hintText:
                                  "DD / MM / YYYY", // fixed typo: was "DD / MM /YYY"
                              obscureText: false,
                              readOnly:
                                  true, // NEW: blocks manual typing entirely
                              onTap: () => _pickDateOfBirth(context),
                              textInputType: TextInputType
                                  .datetime, // NEW: opens the date picker instead
                              validator: ValidationFunctions
                                  .validateDateOfBirth, // NEW: validates date
                            ),
                            Gap(16),
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: CustomTextPoppins(
                                text: "Password",
                                fontWeight: .w600,
                                fontSize: 15,
                                color: myColors().lettersAndIcons,
                              ),
                            ),
                            Gap(16),
                            CustomTextField(
                              controller: passwordController,
                              hintText: "● ● ● ● ● ● ● ● ● ",
                              isThereIcon: true,
                              svgIcon: 'assets/svgs/Eye-Pass.svg',
                              obscureText: true,
                              textInputType: TextInputType.number,
                              validator: ValidationFunctions.validatePassword,
                            ),
                            Gap(16),
                            Padding(
                              padding: EdgeInsetsGeometry.only(left: 18),
                              child: CustomTextPoppins(
                                text: "Confirm Password",
                                fontWeight: .w600,
                                fontSize: 15,
                                color: myColors().lettersAndIcons,
                              ),
                            ),
                            Gap(3),
                            CustomTextField(
                              isThereIcon: true,
                              svgIcon: 'assets/svgs/Eye-Pass.svg',
                              controller: confirmPasswordController,
                              hintText: "● ● ● ● ● ● ● ● ● ",
                              obscureText: true,
                              textInputType: TextInputType.number,
                              validator: ValidationFunctions.validatePassword,
                            ),
                          ],
                        ),
                      ),
                      Gap(28),
                      Center(
                        child: Text(
                          "By continuing you agree to",
                          style: GoogleFonts.leagueSpartan(
                            fontSize: 14,
                            color: Color(0xff4B4544),
                          ),
                        ),
                      ),
                      Center(
                        child: Text.rich(
                          TextSpan(
                            style: GoogleFonts.leagueSpartan(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff4B4544),
                            ),
                            children: [
                              const TextSpan(text: "Terms of Use"),
                              TextSpan(
                                text: 'and',
                                style: GoogleFonts.leagueSpartan(
                                  fontWeight: .w300,
                                ),
                              ),
                              TextSpan(text: " Privacy Policy"),
                            ],
                          ),
                        ),
                      ),
                      Gap(13),
                      Center(
                        child: CustomButton(
                          onTap: signUp,
                          text: 'Sign Up',
                          width: 207,
                          height: 45,
                          backgroundColor: myColors().mainGreen,
                          textColor: myColors().lettersAndIcons,
                        ),
                      ),
                      Gap(11),
                      Center(
                        child: Text.rich(
                          TextSpan(
                            text: 'Already have an account?',
                            style: GoogleFonts.leagueSpartan(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              color: myColors().lettersAndIcons,
                            ),
                            children: [
                              TextSpan(
                                recognizer: _logInRecognizer,
                                text: ' Log In',
                                style: GoogleFonts.leagueSpartan(
                                  fontWeight: .w300,
                                  color: myColors().blueButton,
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
            ],
          ),
        ),
      ),
    );
  }
}
