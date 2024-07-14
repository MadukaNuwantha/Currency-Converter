import 'package:currency_converter/services/currency_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CurrencyService>(context, listen: false).checkCurrencyStatus(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
