import 'package:currency_converter/constants.dart';
import 'package:currency_converter/screens/splash_screen.dart';
import 'package:currency_converter/services/currency_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CurrencyService()),
      ],
      child: const CurrencyConverter(),
    ),
  );
}

class CurrencyConverter extends StatelessWidget {
  const CurrencyConverter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Currency Converter',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
