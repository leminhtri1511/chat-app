import 'package:intl/intl.dart';

class StringUtils {
  static String formatMoney(String money) {
    final moneyValue = double.tryParse(
      money.replaceAll(',', ''),
    );
    if (moneyValue != null) {
      final formatter = NumberFormat('#,###', 'vi_VN');
      return formatter.format(moneyValue);
    } else {
      return money;
    }
    // if (moneyValue != null) {
    //   final formatter = NumberFormat('#,###');
    //   return '${formatter.format(moneyValue)} VNĐ';
    // } else {
    //   return '$money VNĐ';
    // }
  }

  static String firstLetterUpperCase(String content) {
    return '${content[0].toUpperCase()}'
        '${content.substring(1)}';
  }

  // static List convertMoneyToArray(String money) =>
  //     money.replaceFirst('VND', '').split('.');

  // static String numberToCurrency(int money) =>
  //     NumberFormat.currency(locale: 'vi_VN', symbol: '').format(money);
  // static bool isURLValid(String data) => Uri.parse(data).host.isNotEmpty;

  // static String formatNumber(String s) =>
  //     NumberFormat.decimalPattern(_locale).format(num.parse(s));
  // static String get currency =>
  //     NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;
  // String price = '';
  // static const _locale = 'en';
}
