import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/my_colors.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  final int selectedIndex;
  final ValueChanged<int> onTap;

  static const List<String> _svgIcons = [
    'assets/svgs/nav_bar_items/Home.svg',
    'assets/svgs/nav_bar_items/Analysis.svg',
    'assets/svgs/nav_bar_items/Transactions.svg',
    'assets/svgs/nav_bar_items/Category.svg',
    'assets/svgs/nav_bar_items/Profile.svg',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        width: double.infinity,
        height: 75,
        decoration: BoxDecoration(
          color: const Color(0xffDFF7E2),
          borderRadius: BorderRadius.circular(150),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 44),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(_svgIcons.length, (index) {
              final isSelected = selectedIndex == index;

              return GestureDetector(
                onTap: () => onTap(index),
                child: Container(
                  width: 57,
                  height: 53,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: isSelected
                        ? myColors.mainGreen
                        : const Color(0xffDFF7E2),
                  ),
                  child: SvgPicture.asset(_svgIcons[index]),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
