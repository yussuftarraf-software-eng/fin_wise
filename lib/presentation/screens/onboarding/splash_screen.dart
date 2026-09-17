import 'package:fin_wise/constants/my_colors.dart';
import 'package:fin_wise/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return; // guard: widget might be gone by the time this fires

    Navigator.pushReplacementNamed(context, AppRoutes.launchScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColors.mainGreen,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/svgs/graph.svg"),
            const Gap(13),
            SvgPicture.asset("assets/svgs/FinWise.svg"),
          ],
        ),
      ),
    );
  }
}
