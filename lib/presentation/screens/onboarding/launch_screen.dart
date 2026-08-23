import 'package:fin_wise/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/my_colors.dart';
import '../../custom_widgets/custom_button.dart';

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColors().backgroundGreenWhite,
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            SvgPicture.asset(
              "assets/svgs/graph.svg",
              color: myColors().mainGreen,
            ),
            Gap(13),
            SvgPicture.asset(
              "assets/svgs/FinWise.svg",
              color: myColors().mainGreen,
            ),
            Gap(7),
            Text(
              "Lorem ipsum dolor sit amet, consectetur \nadipiscing elit, sed do eiusmod.",
              textAlign: .center,
              style: GoogleFonts.leagueSpartan(
                fontSize: 14,
                color: Color(0xff4B4544),
              ),
            ),
            Gap(42),
            //login button
            CustomButton(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.loginScreen);
              },
              text: 'Log In',
              width: 207,
              height: 45,
              backgroundColor: myColors().mainGreen,
              textColor: myColors().lettersAndIcons,
            ),
            Gap(12),
            //sign up button
            CustomButton(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.signUp);
              },
              text: 'Sign Up',
              width: 207,
              height: 45,
              backgroundColor: myColors().lightGreen,
              textColor: myColors().lettersAndIcons,
            ),
            Gap(12),
            //forgot password text with gesture detector on it
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.forgotPassword);
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
          ],
        ),
      ),
    );
  }
}
