import 'package:fin_wise/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomNotificationButton extends StatelessWidget {
  const CustomNotificationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.notificationScreen);
      },
      child: SvgPicture.asset("assets/svgs/Icon-Notification.svg"),
    );
  }
}
