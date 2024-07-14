import 'dart:ui';

import 'package:currency_converter/constants.dart';
import 'package:currency_converter/models/currency_model.dart';
import 'package:currency_converter/services/currency_service.dart';
import 'package:currency_converter/widgets/custom_submit_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfirmCurrencyDeleteDialog extends StatelessWidget {
  final Currency currency;

  const ConfirmCurrencyDeleteDialog({
    super.key,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Dialog(
        backgroundColor: kBackgroundColor,
        surfaceTintColor: kBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  'Confirm Removal',
                  style: TextStyle(
                    color: kWhiteColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  'Are you sure you remove the selected preferred currency from ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kGreyAccentColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Icon(
                Icons.currency_exchange,
                color: kWhiteColor,
                size: 100,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CustomSubmitButton(
                      title: 'No',
                      backgroundColor: kBlackColor,
                      textColor: kWhiteColor,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: CustomSubmitButton(
                      title: 'Yes',
                      backgroundColor: kGreenAccentColor,
                      textColor: kWhiteColor,
                      onTap: () {
                        Provider.of<CurrencyService>(context, listen: false).removeSelectedCurrency(currency);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
