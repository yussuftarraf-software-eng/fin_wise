import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/my_colors.dart';
import '../../route.dart';

class CustomNavBar extends StatefulWidget {
  final int isPageSelected;
  CustomNavBar({super.key, required this.isPageSelected});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

navigate(int n) {
  switch (n) {
    case 0:
      return AppRoutes.homeScreen;
    case 1:
      return AppRoutes.analysisScreen;
    case 2:
      return AppRoutes.transactionScreen;
    case 3:
      return AppRoutes.categoryScreen;
    case 4:
      return AppRoutes.myProfileScreen;
  }
}

class _CustomNavBarState extends State<CustomNavBar> {
  List<String> svgIcons = [
    "assets/svgs/nav_bar_items/Home.svg",
    "assets/svgs/nav_bar_items/Analysis.svg",
    "assets/svgs/nav_bar_items/Transactions.svg",
    "assets/svgs/nav_bar_items/Category.svg",
    "assets/svgs/nav_bar_items/Profile.svg",
  ];
  late int isPageSelected = widget.isPageSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffDFF7E2),
        borderRadius: BorderRadius.circular(150),
      ),
      width: double.infinity,
      height: 108,
      child: Row(
        mainAxisAlignment: .center,
        children: [
          ...List.generate(5, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  isPageSelected = index;
                });
                Navigator.pushNamed(context, navigate(index)!);
              },
              child: Padding(
                padding: EdgeInsets.only(right: 24),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: isPageSelected == index
                        ? myColors().mainGreen
                        : Color(0xffDFF7E2),
                  ),
                  width: 57,
                  height: 53,
                  alignment: Alignment.center,
                  child: SvgPicture.asset(svgIcons[index]),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
