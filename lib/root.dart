import 'package:fin_wise/constants/my_colors.dart';
import 'package:fin_wise/presentation/custom_widgets/custom_nav_bar.dart';
import 'package:fin_wise/presentation/screens/main_screens/analysis_screen.dart';
import 'package:fin_wise/presentation/screens/main_screens/category_screen.dart';
import 'package:fin_wise/presentation/screens/main_screens/home_screen.dart';
import 'package:fin_wise/presentation/screens/main_screens/my_profile_screen.dart';
import 'package:fin_wise/presentation/screens/main_screens/transaction_screen.dart';
import 'package:flutter/material.dart';

class Root extends StatefulWidget {
  const Root({super.key, this.isPageSelected = 0});

  final int isPageSelected;

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  late final PageController _pageController;
  late int _selectedIndex;

  final List<Widget> _screens = [
    HomeScreen(),
    AnalysisScreen(),
    TransactionScreen(),
    CategoryScreen(),
    MyProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();

    _selectedIndex = widget.isPageSelected;
    _pageController = PageController(initialPage: _selectedIndex);
  }

  void _changePage(int index) {
    setState(() {
      _selectedIndex = index;
    });

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColors.backgroundGreenWhite,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _screens,
      ),
      bottomNavigationBar: CustomNavBar(
        selectedIndex: _selectedIndex,
        onTap: _changePage,
      ),
    );
  }
}
