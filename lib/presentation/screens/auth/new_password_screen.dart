import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../constants/my_colors.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_main_app_container.dart';
import '../../custom_widgets/custom_text_form_field.dart';
import '../../custom_widgets/custom_text_poppins.dart';

class NewPasswordScreen extends StatelessWidget {
  NewPasswordScreen({super.key});
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController newPasswordConfirmationController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColors.mainGreen,
      body: Center(
        child: Column(
          children: [
            Gap(100),
            CustomTextPoppins(
              text: 'New Password',
              fontWeight: .w600,
              fontSize: 30,
              color: myColors.lettersAndIcons,
            ),
            Gap(65),
            CustomMainAppContainer(
              EdgeRaduis: 100,
              backgroundColor: myColors.backgroundGreenWhite,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Gap(87),
                    CustomTextPoppins(
                      text: "New Password",
                      fontWeight: .w600,
                      fontSize: 15,
                      color: myColors.lettersAndIcons,
                    ),
                    Gap(8),
                    CustomTextField(
                      isThereIcon: true,
                      svgIcon: 'assets/svgs/Eye-Pass.svg',
                      controller: newPasswordController,
                      hintText: '● ● ● ● ● ● ● ● ● ',
                      obscureText: true,
                      textInputType: TextInputType.number,
                    ),
                    Gap(42),
                    CustomTextPoppins(
                      text: "Confirm New Password",
                      fontWeight: .w600,
                      fontSize: 15,
                      color: myColors.lettersAndIcons,
                    ),
                    Gap(8),
                    CustomTextField(
                      isThereIcon: true,
                      svgIcon: 'assets/svgs/Eye-Pass.svg',
                      controller: newPasswordController,
                      hintText: '● ● ● ● ● ● ● ● ● ',
                      obscureText: true,
                      textInputType: TextInputType.number,
                    ),
                    Gap(169),
                    CustomButton(
                      text: 'Change Password',
                      width: 357,
                      height: 45,
                      backgroundColor: myColors.mainGreen,
                      textColor: myColors.lettersAndIcons,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
