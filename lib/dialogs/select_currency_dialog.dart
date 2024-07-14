// ignore_for_file: use_build_context_synchronously

import 'dart:ui';

import 'package:currency_converter/constants.dart';
import 'package:currency_converter/services/currency_service.dart';
import 'package:currency_converter/services/shared_preference_service.dart';
import 'package:currency_converter/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectCurrencyDialog extends StatelessWidget {
  const SelectCurrencyDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: kBackgroundColor,
        surfaceTintColor: kBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select a currency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kWhiteColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.clear,
                    color: kWhiteColor,
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hintText: 'Search Currency',
              onChanged: (searchValue) {
                Provider.of<CurrencyService>(context, listen: false).filterCurrencyList(searchValue);
              },
            ),
          ],
        ),
        titlePadding: const EdgeInsets.all(20),
        content: Consumer<CurrencyService>(
          builder: (context, currencyService, child) {
            return SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: currencyService.filteredCurrencyList.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () async {
                      await SharedPreferenceService().addSelectedCurrency(
                        currencyService.filteredCurrencyList[index].code.toString(),
                      );
                      currencyService.selectedCurrencyList.add(
                        currencyService.filteredCurrencyList[index].code.toString(),
                      );
                      await currencyService.getCurrencyRates(
                        context,
                        currencyService.selectedCurrencyList,
                      );
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currencyService.filteredCurrencyList[index].name.toString(),
                            style: TextStyle(
                              color: kWhiteColor,
                            ),
                          ),
                          Text(
                            currencyService.filteredCurrencyList[index].code.toString(),
                            style: TextStyle(
                              color: kGreyAccentColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
