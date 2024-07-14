import 'package:currency_converter/constants.dart';
import 'package:currency_converter/dialogs/confirm_currency_delete_dialog.dart';
import 'package:currency_converter/dialogs/select_base_currency_dialog.dart';
import 'package:currency_converter/dialogs/select_currency_dialog.dart';
import 'package:currency_converter/services/currency_service.dart';
import 'package:currency_converter/widgets/add_currency_button.dart';
import 'package:currency_converter/widgets/selected_currency_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController valueController = TextEditingController();

  @override
  void initState() {
    super.initState();
    valueController.text = '1';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        surfaceTintColor: kBackgroundColor,
        backgroundColor: kBackgroundColor,
        foregroundColor: kBackgroundColor,
        centerTitle: true,
        leadingWidth: 0,
        title: Text(
          'Currency Converter',
          style: TextStyle(
            color: kWhiteColor,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: kHorizontalPadding,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'INSERT AMOUNT',
                    style: TextStyle(
                      color: kGreyAccentColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Consumer<CurrencyService>(
                builder: (context, currencyService, child) {
                  return Container(
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
                          child: TextFormField(
                            style: TextStyle(
                              color: kWhiteColor,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            cursorColor: kWhiteColor,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            controller: valueController,
                            onChanged: (value) {
                              if (value.isEmpty) {
                                currencyService.updateCurrencyValue('0');
                              } else {
                                currencyService.updateCurrencyValue(value);
                              }
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Provider.of<CurrencyService>(context, listen: false).getCurrencies(context).whenComplete(
                              () {
                                showDialog(
                                  context: context,
                                  builder: (context) => const SelectBaseCurrencyDialog(),
                                );
                              },
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                currencyService.baseCurrency,
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
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'CONVERT TO',
                    style: TextStyle(
                      color: kGreyAccentColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Consumer<CurrencyService>(
                builder: (context, currencyService, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: currencyService.selectedCurrencyRates.length,
                    itemBuilder: (context, index) {
                      final currency = currencyService.selectedCurrencyRates[index];
                      return Dismissible(
                        key: Key(
                          currency.code.toString(),
                        ),
                        direction: DismissDirection.endToStart,
                        confirmDismiss: (direction) async {
                          showDialog(
                            context: context,
                            builder: (context) => ConfirmCurrencyDeleteDialog(
                              currency: currency,
                            ),
                          );
                          return null;
                        },
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        child: SelectedCurrencyItem(
                          currency: currency,
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              AddCurrencyButton(
                title: '+ ADD CONVERTER',
                onTap: () {
                  Provider.of<CurrencyService>(context, listen: false).getCurrencies(context).whenComplete(
                    () {
                      showDialog(
                        context: context,
                        builder: (context) => const SelectCurrencyDialog(),
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
