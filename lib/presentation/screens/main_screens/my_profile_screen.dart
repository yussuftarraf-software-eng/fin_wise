import 'package:fin_wise/presentation/custom_widgets/custom_profile_row_element.dart';
import 'package:fin_wise/presentation/custom_widgets/custom_profile_scaffold.dart';
import 'package:fin_wise/route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomProfileScaffold(
      title: "Profile",
      name: "John Smith",
      id: "123456789",
      body: Column(
        children: [
          CustomProfileRowElement(
            image: "assets/svgs/profile/Icon Profile.svg",
            text: "Edit Profile",
            function: () =>
                Navigator.pushNamed(context, AppRoutes.editProfileScreen),
          ),
          const Gap(34),
          CustomProfileRowElement(
            image: "assets/svgs/profile/Icon Security.svg",
            text: "Security",
          ),
          const Gap(34),
          CustomProfileRowElement(
            image: "assets/svgs/profile/Icon Setting.svg",
            text: "Settings",
          ),
          const Gap(34),
          CustomProfileRowElement(
            image: "assets/svgs/profile/Icon help.svg",
            text: "Help",
          ),
          const Gap(34),
          CustomProfileRowElement(
            image: "assets/svgs/profile/Icon Logout.svg",
            text: "Logout",
          ),
        ],
      ),
    );
  }
}
