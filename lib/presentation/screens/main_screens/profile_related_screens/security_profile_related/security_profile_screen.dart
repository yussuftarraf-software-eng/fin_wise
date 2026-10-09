import 'package:fin_wise/data/web_services/dio_consumer.dart';
import 'package:fin_wise/presentation/custom_widgets/custom_main_app_container.dart';
import 'package:fin_wise/presentation/custom_widgets/custom_text_poppins.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../constants/my_colors.dart';
import '../../../../custom_widgets/custom_notification_button.dart';

class SecurityProfileScreen extends StatelessWidget {
  const SecurityProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColors.mainGreen,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text("Security"),
        backgroundColor: myColors.mainGreen,
        actions: const [CustomNotificationButton(), Gap(36)],
      ),
      body: Column(
        children: [
          Gap(20),
          CustomMainAppContainer(
            EdgeRaduis: 100,
            backgroundColor: myColors.backgroundGreenWhite,
            child: Padding(
              padding: const EdgeInsets.only(left: 38, right: 38),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Gap(51),
                  CustomTextPoppins(
                    text: "Security",
                    fontWeight: .w600,
                    fontSize: 20,
                    color: myColors.lettersAndIcons,
                  ),
                  Gap(55),
                  SecurityRow("Change Pin", () {}),
                  Gap(31),
                  SecurityRow("FingerPrint", () {}),
                  Gap(31),
                  SecurityRow("Terms and Conditions", () {}),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget SecurityRow(String text, GestureTapCallback function) {
  return Column(
    children: [
      GestureDetector(
        onTap: function,
        child: Row(
          children: [
            CustomTextPoppins(
              text: text,
              fontWeight: .w500,
              fontSize: 15,
              color: myColors.lettersAndIcons,
            ),
            Spacer(),
            Icon(CupertinoIcons.forward),
          ],
        ),
      ),
      Gap(29),
      Divider(color: Colors.black, height: 1.4),
    ],
  );
}
