// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:currency_converter/constants.dart';
import 'package:currency_converter/dialogs/custom_loading_dialog.dart';
import 'package:currency_converter/models/currency_model.dart';
import 'package:currency_converter/screens/home_screen.dart';
import 'package:currency_converter/services/shared_preference_service.dart';
import 'package:currency_converter/widgets/snack_bars.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CurrencyService extends ChangeNotifier {
  List<Currency> currencyList = [];
  List<Currency> filteredCurrencyList = [];
  String baseCurrency = '';
  List<String> selectedCurrencyList = [];
  List<Currency> selectedCurrencyRates = [];
  double currencyValue = 1.0;

  void filterCurrencyList(String query) {
    if (query.isEmpty) {
      filteredCurrencyList = currencyList;
    } else {
      filteredCurrencyList = currencyList
          .where(
            (currency) =>
                currency.code!.toLowerCase().contains(query.toLowerCase()) ||
                currency.name!.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
    notifyListeners();
  }

  void updateCurrencyValue(String value) {
    currencyValue = double.parse(value.toString());
    notifyListeners();
  }

  void removeSelectedCurrency(Currency currency) {
    selectedCurrencyRates.remove(currency);
    selectedCurrencyList.remove(currency.code.toString());
    SharedPreferenceService().removeSelectedCurrency(
      currency.code.toString(),
    );
    notifyListeners();
  }

  Future<void> checkCurrencyStatus(BuildContext context) async {
    baseCurrency = await SharedPreferenceService().getBaseCurrency();
    selectedCurrencyList = await SharedPreferenceService().getSelectedCurrencies();
    await setBaseCurrency(context, baseCurrency);
    await getCurrencyRates(context, selectedCurrencyList);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
      (route) => true,
    );
  }

  Future<void> getCurrencies(
    BuildContext context,
  ) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const CustomLoadingDialog(
          title: 'Retrieving Currencies',
        ),
      );
      final response = await http.get(
        Uri.parse('${baseUrl}currencies.json'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      Navigator.pop(context);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData.isNotEmpty) {
          currencyList = responseData.entries.map((entry) {
            return Currency(code: entry.key, name: entry.value);
          }).toList();
          filteredCurrencyList = currencyList;
        }
        notifyListeners();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          errorSnackBar('Could not retrieve currencies'),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        errorSnackBar(e.toString()),
      );
    }
  }

  Future<void> setBaseCurrency(
    BuildContext context,
    String baseCurrency,
  ) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const CustomLoadingDialog(
          title: 'Setting Base Currency',
        ),
      );
      final response = await http.get(
        Uri.parse('${baseUrl}latest.json?app_id=$apiKey&base=$baseCurrency'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      Navigator.pop(context);
      if (response.statusCode == 200) {
        SharedPreferenceService().saveBaseCurrency(baseCurrency);
        notifyListeners();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          errorSnackBar('Could not set base currency'),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        errorSnackBar(e.toString()),
      );
    }
  }

  Future<void> getCurrencyRates(
    BuildContext context,
    List<String> selectedCurrencies,
  ) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const CustomLoadingDialog(
          title: 'Retrieving Currency Rates',
        ),
      );
      final response = await http.get(
        Uri.parse('${baseUrl}latest.json?app_id=$apiKey&symbols=${selectedCurrencies.join(',')}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      Navigator.pop(context);
      if (response.statusCode == 200) {
        selectedCurrencyRates.clear();
        final responseData = jsonDecode(response.body);
        if (responseData['rates'].isNotEmpty) {
          responseData['rates'].entries.map((entry) {
            selectedCurrencyRates.add(
              Currency(
                code: entry.key,
                name: '',
                rate: double.parse(entry.value.toString()),
              ),
            );
          }).toList();
        }
        notifyListeners();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          errorSnackBar('Could not retrieve currency rates'),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        errorSnackBar(e.toString()),
      );
    }
  }
}
