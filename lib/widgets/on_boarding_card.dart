import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:quick_note/colors/dynamic_color.dart';
import 'package:quick_note/data/onboarding.dart';

class OnBoardingCard extends StatelessWidget {
  final Onboarding onBoarding;
  final int index;

  const OnBoardingCard(
      {super.key, required this.onBoarding, required this.index});

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      duration: const Duration(milliseconds: 1400),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(onBoarding.image), fit: BoxFit.fill)),
        child: Column(
          children: [
            const Spacer(),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: onBoarding.title1,
                  style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryColor),
                  children: [
                    TextSpan(
                      text: onBoarding.title2,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 36),
                    )
                  ]),
            ),
            const SizedBox(height: 20),
            Text(
              onBoarding.description,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondaryColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
