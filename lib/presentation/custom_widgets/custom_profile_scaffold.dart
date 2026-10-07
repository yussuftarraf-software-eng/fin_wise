import 'package:fin_wise/presentation/custom_widgets/custom_main_app_container.dart';
import 'package:fin_wise/presentation/custom_widgets/custom_notification_button.dart';
import 'package:fin_wise/presentation/custom_widgets/custom_text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../constants/my_colors.dart';

class CustomProfileScaffold extends StatelessWidget {
  const CustomProfileScaffold({
    super.key,
    required this.title,
    required this.name,
    required this.id,
    required this.body,
    this.imageProvider,
    this.bodyTopOffset = 174,
    this.bodyLeftPadding = 38,
  });

  final String title;
  final String name;
  final String id;

  /// The part that changes per screen (e.g. the list of CustomProfileRowElement)
  final Widget body;

  /// Pass NetworkImage / AssetImage. Falls back to the placeholder asset.
  final ImageProvider? imageProvider;

  final double bodyTopOffset;
  final double bodyLeftPadding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColors.mainGreen,
      appBar: AppBar(
        backgroundColor: myColors.mainGreen,
        title: CustomTextPoppins(
          text: title,
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: myColors.lettersAndIcons,
        ),
        centerTitle: true,
        actions: const [CustomNotificationButton(), Gap(36)],
      ),
      body: Column(
        children: [
          const Gap(90),
          CustomMainAppContainer(
            EdgeRaduis: 100,
            backgroundColor: myColors.backgroundGreenWhite,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Name and ID
                Padding(
                  padding: const EdgeInsets.only(top: 76),
                  child: Align(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomTextPoppins(
                          text: name,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: myColors.darkModeGreenBar,
                        ),
                        CustomTextPoppins(
                          text: "ID: $id",
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: myColors.lettersAndIcons,
                        ),
                      ],
                    ),
                  ),
                ),
                // Custom body (the only part that varies)
                Positioned(
                  top: bodyTopOffset,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.only(left: bodyLeftPadding),
                    child: body,
                  ),
                ),
                // Profile picture
                Positioned(
                  top: -45,
                  left: 0,
                  right: 0,
                  child: Center(child: _ProfileImage(imageProvider)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileImage extends StatelessWidget {
  const _ProfileImage(this.imageProvider);

  final ImageProvider? imageProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 117,
      height: 117,
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: ClipOval(
        child: Image(
          image:
              imageProvider ??
              const AssetImage('assets/images/profile image placeholder.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
