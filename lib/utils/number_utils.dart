class NumberUtils {
  static const double MILLION = 10000.0;
  static const double MILLIONS = 1000000.0;
  static const double BILLION = 100000000.0;
  static const String MILLION_UNIT = "万";
  static const String BILLION_UNIT = "亿";

  static String amountConversion(num amount) {
    String result = amount.toString();

    if (amount > MILLION * 10 && amount <= MILLIONS) {
      result = '${(amount / MILLION).toStringAsFixed(1)}$MILLION_UNIT';
    } else if (amount > MILLIONS && amount <= BILLION) {
      if (amount == BILLION) {
        result = '${amount ~/ BILLION}$BILLION_UNIT';
      } else {
        result = '${amount ~/ MILLION}$MILLION_UNIT';
      }
    } else if (amount > BILLION) {
      result = '${amount ~/ BILLION}$BILLION_UNIT';
    } else {
      result = amount.toString();
    }
    return result;
  }

  static String formatNum(num n) {
    if (n >= MILLION) {
      var r = n ~/ MILLION;
      return '${r >= 10 ? 10 : r}w+';
    } else {
      return '$n';
    }
  }
}
