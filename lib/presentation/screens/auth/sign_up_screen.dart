import 'package:fin_wise/constants/my_colors.dart';
import 'package:fin_wise/data/repository/auth_implementaion.dart';
import 'package:fin_wise/data/web_services/dio_consumer.dart';
import 'package:fin_wise/domain/functions/validation_functions.dart';
import 'package:fin_wise/presentation/screens/auth/auth_cubit/auth_cubit.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_cubit/auth_cubit.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  late TapGestureRecognizer _logInRecognizer = TapGestureRecognizer();
  final AuthCubit authCubit = AuthCubit();

  Future<void> _pickDateOfBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
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

  // Future<dynamic> signUp() async {
  //   final response = await AuthImplementation(DioConsumer()).signUp(
  //     UserModelSignUp(
  //       firstName: fullNameController.text,
  //       lastName: emailController.text,
  //       age: 20,
  //     ),
  //   );
  //   FocusManager.instance.primaryFocus?.unfocus();
  //   print("${response.firstName} ${response.lastName} ${response.age}");
  //   Navigator.pushNamed(context, AppRoutes.homeScreen);
  // }

  @override
  void initState() {
    super.initState();
    _logInRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pushNamed(context, '/LoginScreen');
      };
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    mobileNumberController.dispose();
    dateOfBirthController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    _logInRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => authCubit,
      child: Scaffold(
        backgroundColor: myColors.mainGreen,
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody:
                      false, // Essential: enables Expanded to work inside Column
                  child: Column(
                    children: [
                      const Gap(
                        40,
                      ), // Adjusted top spacing for better safe area fit
                      CustomTextPoppins(
                        text: "Create Account",
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                        color: myColors.lettersAndIcons,
                      ),
                      const Gap(30),
                      Expanded(
                        child: CustomMainAppContainer(
                          EdgeRaduis: 100,
                          backgroundColor:
                              myColors.backgroundDarkModeAndLetters,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 37),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Gap(27),
                                Padding(
                                  padding: const EdgeInsets.only(left: 18),
                                  child: CustomTextPoppins(
                                    text: "Full Name",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: myColors.lettersAndIcons,
                                  ),
                                ),
                                const Gap(3),
                                Form(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomTextField(
                                        controller: fullNameController,
                                        hintText: 'Jeff Nippard',
                                        obscureText: false,
                                        textInputType: TextInputType.name,
                                        validator: ValidationFunctions
                                            .validateFullName,
                                      ),
                                      const Gap(16),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 18.0,
                                        ),
                                        child: CustomTextPoppins(
                                          text: "Email",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: myColors.lettersAndIcons,
                                        ),
                                      ),
                                      const Gap(3),
                                      CustomTextField(
                                        controller: emailController,
                                        hintText: 'example@example.com',
                                        obscureText: false,
                                        textInputType:
                                            TextInputType.emailAddress,
                                        validator:
                                            ValidationFunctions.validateEmail,
                                      ),
                                      const Gap(16),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 18.0,
                                        ),
                                        child: CustomTextPoppins(
                                          text: "Mobile Number",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: myColors.lettersAndIcons,
                                        ),
                                      ),
                                      const Gap(3),
                                      CustomTextField(
                                        controller: mobileNumberController,
                                        hintText: "+251912345678",
                                        obscureText: false,
                                        textInputType: TextInputType.phone,
                                        validator: ValidationFunctions
                                            .validateMobileNumber,
                                      ),
                                      const Gap(16),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 18.0,
                                        ),
                                        child: CustomTextPoppins(
                                          text: "Date of Birth",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: myColors.lettersAndIcons,
                                        ),
                                      ),
                                      const Gap(3),
                                      CustomTextField(
                                        controller: dateOfBirthController,
                                        hintText: "DD / MM / YYYY",
                                        obscureText: false,
                                        readOnly: true,
                                        onTap: () => _pickDateOfBirth(context),
                                        textInputType: TextInputType.datetime,
                                        validator: ValidationFunctions
                                            .validateDateOfBirth,
                                      ),
                                      const Gap(16),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 18.0,
                                        ),
                                        child: CustomTextPoppins(
                                          text: "Password",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: myColors.lettersAndIcons,
                                        ),
                                      ),
                                      const Gap(3),
                                      CustomTextField(
                                        controller: passwordController,
                                        hintText: "● ● ● ● ● ● ● ● ● ",
                                        isThereIcon: true,
                                        svgIcon: 'assets/svgs/Eye-Pass.svg',
                                        obscureText: true,
                                        textInputType: TextInputType.number,
                                        validator: ValidationFunctions
                                            .validatePassword,
                                      ),
                                      const Gap(16),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 18,
                                        ),
                                        child: CustomTextPoppins(
                                          text: "Confirm Password",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: myColors.lettersAndIcons,
                                        ),
                                      ),
                                      const Gap(3),
                                      CustomTextField(
                                        isThereIcon: true,
                                        svgIcon: 'assets/svgs/Eye-Pass.svg',
                                        controller: confirmPasswordController,
                                        hintText: "● ● ● ● ● ● ● ● ● ",
                                        obscureText: true,
                                        textInputType: TextInputType.number,
                                        validator: ValidationFunctions
                                            .validatePassword,
                                      ),
                                    ],
                                  ),
                                ),
                                const Gap(28),
                                Center(
                                  child: Text(
                                    "By continuing you agree to",
                                    style: GoogleFonts.leagueSpartan(
                                      fontSize: 14,
                                      color: const Color(0xff4B4544),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text.rich(
                                    TextSpan(
                                      style: GoogleFonts.leagueSpartan(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xff4B4544),
                                      ),
                                      children: [
                                        const TextSpan(text: "Terms of Use "),
                                        TextSpan(
                                          text: 'and ',
                                          style: GoogleFonts.leagueSpartan(
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        const TextSpan(text: "Privacy Policy"),
                                      ],
                                    ),
                                  ),
                                ),
                                const Gap(13),
                                Center(
                                  child: BlocListener<AuthCubit, AuthState>(
                                    listener: (context, state) {
                                      if (state is AuthSuccess) {
                                        Navigator.pushNamed(
                                          context,
                                          AppRoutes.root,
                                        );
                                      }

                                      if (state is AuthFailure) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(state.message),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    },
                                    child: BlocBuilder<AuthCubit, AuthState>(
                                      builder: (context, state) {
                                        return (authCubit.state is AuthLoading)
                                            ? CircularProgressIndicator(
                                                color: myColors.mainGreen,
                                              )
                                            : CustomButton(
                                                onTap: () {
                                                  authCubit.signUp(
                                                    UserModelSignUp(
                                                      firstName:
                                                          fullNameController
                                                              .text,
                                                      lastName: emailController
                                                          .text, // see note below
                                                      age: 20, // see note below
                                                    ),
                                                  );
                                                },
                                                text: 'Sign Up',
                                                width: 207,
                                                height: 45,
                                                backgroundColor:
                                                    myColors.mainGreen,
                                                textColor:
                                                    myColors.lettersAndIcons,
                                              );
                                      },
                                    ),
                                  ),
                                ),
                                const Gap(11),
                                Center(
                                  child: Text.rich(
                                    TextSpan(
                                      text: 'Already have an account?',
                                      style: GoogleFonts.leagueSpartan(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w300,
                                        color: myColors.lettersAndIcons,
                                      ),
                                      children: [
                                        TextSpan(
                                          recognizer: _logInRecognizer,
                                          text: ' Log In',
                                          style: GoogleFonts.leagueSpartan(
                                            fontWeight: FontWeight.w300,
                                            color: myColors.blueButton,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Gap(20), // Bottom padding for safety
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
