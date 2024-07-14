import 'package:currency_converter/constants.dart';
import 'package:currency_converter/models/currency_model.dart';
import 'package:currency_converter/services/currency_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectedCurrencyItem extends StatelessWidget {
  final Currency currency;

  const SelectedCurrencyItem({
    super.key,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: kGreyDarkAccentColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              (currency.rate! * Provider.of<CurrencyService>(context, listen: true).currencyValue).toStringAsFixed(2),
              style: TextStyle(
                color: kWhiteColor,
                fontSize: 23,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            currency.code.toString(),
            style: TextStyle(
              color: kWhiteColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          Icon(
            Icons.keyboard_arrow_down,
            color: kGreyAccentColor,
          ),
        ],
      ),
    );
  }
}
