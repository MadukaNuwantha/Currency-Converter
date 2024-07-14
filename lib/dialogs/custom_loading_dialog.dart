import 'dart:ui';

import 'package:currency_converter/constants.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CustomLoadingDialog extends StatelessWidget {
  final String title;
  const CustomLoadingDialog({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 80,
              child: LoadingIndicator(
                indicatorType: Indicator.ballSpinFadeLoader,
                colors: [
                  kGreyAccentColor,
                ],
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                color: kGreyAccentColor,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
