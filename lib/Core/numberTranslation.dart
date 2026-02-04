import 'package:get/get.dart';

class numberTranslation {

  /// 🔎 check current language
  static bool get _isBangla =>
      Get.locale?.languageCode == 'bn';

  /// ✅ digits only (safe for numbers)
  static String toBnDigits(String input) {
    if (!_isBangla) return input;

    const en = ['0','1','2','3','4','5','6','7','8','9'];
    const bn = ['০','১','২','৩','৪','৫','৬','৭','৮','৯'];

    var out = input;
    for (int i = 0; i < 10; i++) {
      out = out.replaceAll(en[i], bn[i]);
    }
    return out;
  }

  /// ✅ Date string → Bangla ONLY if language is Bangla
  /// Input example: "03 Feb 2026"
  static String formatDateBnFromString(String input) {
    if (!_isBangla) return input; // 👈 English 그대로 ফেরত

    const monthMap = {
      'Jan': 'জানুয়ারি',
      'Feb': 'ফেব্রুয়ারি',
      'Mar': 'মার্চ',
      'Apr': 'এপ্রিল',
      'May': 'মে',
      'Jun': 'জুন',
      'Jul': 'জুলাই',
      'Aug': 'আগস্ট',
      'Sep': 'সেপ্টেম্বর',
      'Oct': 'অক্টোবর',
      'Nov': 'নভেম্বর',
      'Dec': 'ডিসেম্বর',
    };

    final parts = input.split(' '); // dd MMM yyyy
    if (parts.length != 3) return input;

    final day = toBnDigits(parts[0]);
    final month = monthMap[parts[1]] ?? parts[1];
    final year = toBnDigits(parts[2]);

    return "$day $month $year";
  }

  static String formatMonthYearBnFromString(String input) {
    if (!_isBangla) return input; // 👈 English 그대로 ফেরত

    const monthMap = {
      'Jan': 'জানুয়ারি',
      'Feb': 'ফেব্রুয়ারি',
      'Mar': 'মার্চ',
      'Apr': 'এপ্রিল',
      'May': 'মে',
      'Jun': 'জুন',
      'Jul': 'জুলাই',
      'Aug': 'আগস্ট',
      'Sep': 'সেপ্টেম্বর',
      'Oct': 'অক্টোবর',
      'Nov': 'নভেম্বর',
      'Dec': 'ডিসেম্বর',
    };

    final parts = input.split(' '); // MMM yyyy
    if (parts.length != 2) return input;

    final month = monthMap[parts[0]] ?? parts[0];
    final year = toBnDigits(parts[1]);

    return "$month $year";
  }

  static String formatMonthYearBnFromKey(String input) {
    if (!_isBangla) return input; // 👈 English 그대로 ফেরত

    const monthMap = {
      '01': 'জানুয়ারি',
      '02': 'ফেব্রুয়ারি',
      '03': 'মার্চ',
      '04': 'এপ্রিল',
      '05': 'মে',
      '06': 'জুন',
      '07': 'জুলাই',
      '08': 'আগস্ট',
      '09': 'সেপ্টেম্বর',
      '10': 'অক্টোবর',
      '11': 'নভেম্বর',
      '12': 'ডিসেম্বর',
    };

    final parts = input.split('-'); // yyyy-MM
    if (parts.length != 2) return input;

    final year = toBnDigits(parts[0]);
    final month = monthMap[parts[1]] ?? parts[1];

    return "$month $year";
  }

}
