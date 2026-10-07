import 'package:fin_wise/constants/my_colors.dart';
import 'package:fin_wise/presentation/custom_widgets/custom_text_form_field.dart';
import 'package:fin_wise/presentation/custom_widgets/custom_text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../route.dart';
import '../../../custom_widgets/custom_profile_row_element.dart';
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
  @override
  Widget build(BuildContext context) {
    return CustomProfileScaffold(
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
          Gap(40),
          Row(children: []),
        ],
      ),
    );
  }
}
