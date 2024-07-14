import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  Future<void> saveBaseCurrency(String currency) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('baseCurrency', currency);
  }

  Future<String> getBaseCurrency() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('baseCurrency') ?? 'USD';
  }

  Future<void> saveSelectedCurrencies(List<String> currencies) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('selectedCurrencies', currencies);
  }

  Future<List<String>> getSelectedCurrencies() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('selectedCurrencies') ?? ['LKR'];
  }

  Future<void> addSelectedCurrency(String currency) async {
    List<String> currentCurrencies = await getSelectedCurrencies();
    if (!currentCurrencies.contains(currency)) {
      currentCurrencies.add(currency);
      await saveSelectedCurrencies(currentCurrencies);
    }
  }

  Future<void> removeSelectedCurrency(String currency) async {
    List<String> currentCurrencies = await getSelectedCurrencies();
    currentCurrencies.remove(currency);
    await saveSelectedCurrencies(currentCurrencies);
  }
}
