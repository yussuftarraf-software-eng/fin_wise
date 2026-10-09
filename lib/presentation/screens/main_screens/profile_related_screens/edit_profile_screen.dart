import 'package:fin_wise/constants/my_colors.dart';
import 'package:fin_wise/presentation/custom_widgets/custom_button.dart';
import 'package:fin_wise/presentation/custom_widgets/custom_text_form_field.dart';
import 'package:fin_wise/presentation/custom_widgets/custom_text_poppins.dart';
import 'package:fin_wise/root.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/shared_prefs_service.dart';
import '../../../custom_widgets/custom_profile_scaffold.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController userName = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController emailAddress = TextEditingController();
  bool isNotificationOn = false;
  @override
  Widget build(BuildContext context) {
    return CustomProfileScaffold(
      isImagePickerShow: true,
      title: "Edit My Profile",
      name: "John Smith",
      id: "123456789",
      body: Column(
        crossAxisAlignment: .start,
        children: [
          CustomTextPoppins(
            text: 'Account Settings',
            fontWeight: .w600,
            fontSize: 20,
            color: myColors.lettersAndIcons,
          ),
          Gap(20),
          CustomTextPoppins(
            text: "Username",
            fontWeight: .w600,
            fontSize: 14,
            color: myColors.lettersAndIcons,
          ),
          Gap(12),
          CustomTextField(
            controller: userName,
            hintText: "John Smith",
            obscureText: false,
            textInputType: .name,
          ),
          Gap(10),
          CustomTextPoppins(
            text: "Phone",
            fontWeight: .w600,
            fontSize: 14,
            color: myColors.lettersAndIcons,
          ),
          Gap(12),
          CustomTextField(
            controller: phone,
            hintText: "+201091419945",
            obscureText: false,
            textInputType: .phone,
          ),
          Gap(10),
          CustomTextPoppins(
            text: "Email Address",
            fontWeight: .w600,
            fontSize: 14,
            color: myColors.lettersAndIcons,
          ),
          Gap(12),
          CustomTextField(
            controller: emailAddress,
            hintText: "john.smith@gmail.com",
            obscureText: false,
            textInputType: .emailAddress,
          ),
          Gap(20),
          Row(
            children: [
              CustomTextPoppins(
                text: "Push Notifications",
                fontWeight: .w600,
                fontSize: 17,
                color: myColors.lettersAndIcons,
              ),
              Spacer(),
              Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: isNotificationOn,
                  onChanged: (value) {
                    setState(() => isNotificationOn = value);
                  },
                  activeThumbColor: Colors.white,
                  activeTrackColor: myColors.mainGreen, // green track
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: myColors.lightGreen,
                ),
              ),
              Gap(30),
            ],
          ),
          Row(
            children: [
              CustomTextPoppins(
                text: "Turn Dark Theme",
                fontWeight: .w600,
                fontSize: 17,
                color: myColors.lettersAndIcons,
              ),
              Spacer(),
              Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: myColors.isDark,
                  onChanged: (value) => myColors.setDarkMode(value),
                  activeThumbColor: Colors.white,
                  activeTrackColor: myColors.mainGreen,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: myColors.lightGreen,
                ),
              ),
              Gap(30),
            ],
          ),
          Gap(20),
          Padding(
            padding: const EdgeInsets.only(right: 38),
            child: Center(
              child: CustomButton(
                onTap: () {
                  setState(() {
                    CacheHelper.removeData(key: 'profile_image_path');
                  });
                },
                text: "Delete image",
                width: 169,
                height: 36,
                backgroundColor: Colors.red,
                textColor: myColors.lettersAndIcons,
                fontSize: 15,
                fontWeight: .w600,
              ),
            ),
          ),

          Gap(10),
          Padding(
            padding: const EdgeInsets.only(right: 38),
            child: Center(
              child: CustomButton(
                onTap: () async {
                  await Future.delayed(const Duration(seconds: 1));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Root(isPageSelected: 4),
                    ),
                  );
                },
                text: "Update Profile",
                width: 169,
                height: 36,
                backgroundColor: myColors.mainGreen,
                textColor: myColors.lettersAndIcons,
                fontSize: 15,
                fontWeight: .w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
