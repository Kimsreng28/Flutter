import 'package:flutter/material.dart';
import 'package:quick_note/colors/dynamic_color.dart';
import 'package:quick_note/data/onboarding.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomIndicator extends StatelessWidget {
  final double position;

  const CustomIndicator({super.key, required this.position});

  @override
  Widget build(BuildContext context) {
    return SmoothIndicator(
      offset: position,
      count: onboardingList.length,
      size: const Size(8, 8),
      effect: WormEffect(
        dotWidth: 8,
        dotHeight: 8,
        spacing: 5,
        dotColor: Colors.grey.withOpacity(0.5),
        activeDotColor: AppColors.primaryColor,
        radius: 8,
      ),
    );
  }
}
