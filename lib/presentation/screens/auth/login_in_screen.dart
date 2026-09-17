import 'dart:math';
import 'package:fin_wise/presentation/custom_widgets/custom_button.dart';
import 'package:fin_wise/route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants/my_colors.dart';
import '../../../data/model/user_model.dart';
import '../../custom_widgets/custom_main_app_container.dart';
import '../../custom_widgets/custom_text_form_field.dart';
import '../../custom_widgets/custom_text_poppins.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_cubit/auth_cubit.dart';

class LoginInScreen extends StatefulWidget {
  const LoginInScreen({super.key});

  @override
  State<LoginInScreen> createState() => _LoginInScreenState();
}

class _LoginInScreenState extends State<LoginInScreen> {
  late final TapGestureRecognizer _fingerprintRecognizer;
  late final TapGestureRecognizer _signUpRecognizer;
  final _formKey = GlobalKey<FormState>();
  final AuthCubit authCubit = AuthCubit();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _fingerprintRecognizer.dispose();
    _signUpRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColors.mainGreen,
      body: BlocProvider(
        create: (context) => authCubit,
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            // LOGIN SUCCESS
            if (state is AuthSuccess) {
              Navigator.pushNamed(context, AppRoutes.root);
            }
            // LOGIN FAILURE
            else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: myColors.darkModeGreenBar,
                  duration: const Duration(seconds: 3),
                ),
              );
            }
          },
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: SafeArea(
              // FIXED: Replaced 'child:' in CustomScrollView with proper 'slivers:' array containing 'SliverFillRemaining'
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody:
                        false, // CHANGED: Allows Expanded inside to expand when keyboard is closed and scroll when open
                    child: Column(
                      children: [
                        const Gap(
                          40,
                        ), // CHANGED: Reduced initial gap slightly from 100 to prevent clipping on smaller devices
                        CustomTextPoppins(
                          text: "Welcome",
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                          color: myColors.lettersAndIcons,
                        ),
                        const Gap(40), // CHANGED: Adjusted gap before container
                        // ADDED: Expanded around container so it stretches vertically across remaining screen space
                        Expanded(
                          child: CustomMainAppContainer(
                            EdgeRaduis: 100,
                            backgroundColor: myColors.backgroundGreenWhite,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 36,
                              ),
                              child: Form(
                                // CHANGED: Moved Form to wrap all input fields and actions together cleanly
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Gap(
                                      40,
                                    ), // CHANGED: Reduced from 90 to balance space dynamically
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      child: CustomTextPoppins(
                                        text: "Username Or Email",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: myColors.lettersAndIcons,
                                      ),
                                    ),
                                    const Gap(8),
                                    CustomTextField(
                                      controller: emailController,
                                      hintText: 'example@example.com',
                                      obscureText: false,
                                      textInputType: TextInputType.emailAddress,
                                    ),
                                    const Gap(23),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      child: CustomTextPoppins(
                                        text: "Password",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
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
                                    ),
                                    const Gap(
                                      40,
                                    ), // CHANGED: Adjusted gap from 91 for smoother layout balance
                                    Center(
                                      child: Column(
                                        children: [
                                          BlocBuilder<AuthCubit, AuthState>(
                                            builder: (context, state) {
                                              return (authCubit.state
                                                      is AuthLoading)
                                                  ? CircularProgressIndicator(
                                                      color: myColors.mainGreen,
                                                    )
                                                  : CustomButton(
                                                      onTap: () {
                                                        //validation of text fields but not working cuz of the differences between logic and api
                                                        // if (_formKey
                                                        //     .currentState!
                                                        //     .validate())
                                                        //   return;
                                                        {
                                                          ScaffoldMessenger.of(
                                                            context,
                                                          ).showSnackBar(
                                                            const SnackBar(
                                                              content: Text(
                                                                'Processing Data',
                                                              ),
                                                            ),
                                                          );
                                                          authCubit.login(
                                                            UserModelSignIn(
                                                              userName:
                                                                  emailController
                                                                      .text,
                                                              password:
                                                                  passwordController
                                                                      .text,
                                                            ),
                                                          );
                                                        }
                                                        print(
                                                          authCubit.state
                                                              .toString(),
                                                        );
                                                      },
                                                      text: "Log in ",
                                                      width: 207,
                                                      height: 45,
                                                      backgroundColor:
                                                          myColors.mainGreen,
                                                      textColor: myColors
                                                          .lettersAndIcons,
                                                    );
                                            },
                                          ),
                                          const Gap(19),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                '/ForgotPassword',
                                              );
                                            },
                                            child: Text(
                                              "Forgot Password?",
                                              style: GoogleFonts.leagueSpartan(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: myColors.lettersAndIcons,
                                              ),
                                            ),
                                          ),
                                          const Gap(14),
                                          CustomButton(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                '/SignUp',
                                              );
                                            },
                                            text: "Sign Up",
                                            width: 207,
                                            height: 45,
                                            backgroundColor:
                                                myColors.lightGreen,
                                            textColor:
                                                myColors.darkModeGreenBar,
                                          ),
                                          const Gap(23),
                                          Text.rich(
                                            TextSpan(
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    myColors.darkModeGreenBar,
                                              ),
                                              children: [
                                                const TextSpan(text: 'Use '),
                                                TextSpan(
                                                  recognizer:
                                                      _fingerprintRecognizer,
                                                  text: 'Fingerprint',
                                                  style: GoogleFonts.poppins(
                                                    color: myColors
                                                        .oceanBlueButton,
                                                  ),
                                                ),
                                                const TextSpan(
                                                  text: ' To Access',
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Gap(28),
                                          Text(
                                            "or sign up with",
                                            style: GoogleFonts.leagueSpartan(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w300,
                                              color: myColors.lettersAndIcons,
                                            ),
                                          ),
                                          const Gap(19),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                "assets/svgs/Facebook.svg",
                                                colorFilter: ColorFilter.mode(
                                                  myColors.darkModeGreenBar,
                                                  BlendMode.srcIn,
                                                ), // CHANGED: Updated deprecated 'color' property to 'colorFilter'
                                              ),
                                              const Gap(17),
                                              SvgPicture.asset(
                                                "assets/svgs/Google.svg",
                                                colorFilter: ColorFilter.mode(
                                                  myColors.darkModeGreenBar,
                                                  BlendMode.srcIn,
                                                ), // CHANGED: Updated deprecated 'color' property to 'colorFilter'
                                              ),
                                            ],
                                          ),
                                          const Gap(20),
                                          Text.rich(
                                            TextSpan(
                                              style: GoogleFonts.leagueSpartan(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w300,
                                                color: myColors.lettersAndIcons,
                                              ),
                                              children: [
                                                const TextSpan(
                                                  text:
                                                      "Don't have an account? ",
                                                ),
                                                TextSpan(
                                                  recognizer: _signUpRecognizer,
                                                  text: 'Sign up',
                                                  style: GoogleFonts.poppins(
                                                    color: myColors.blueButton,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // ADDED: Bottom spacing for safe scrolling margin
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
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
      ),
    );
  }
}
