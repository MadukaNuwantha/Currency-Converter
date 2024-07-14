// ignore_for_file: must_be_immutable

import 'package:currency_converter/constants.dart';
import 'package:flutter/material.dart';

class AddCurrencyButton extends StatelessWidget {
  void Function()? onTap;
  final String title;

  AddCurrencyButton({
    super.key,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: kGreenColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: kGreenAccentColor,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
