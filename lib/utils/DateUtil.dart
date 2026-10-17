import 'package:cattle/models/LocaleModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:shamsi_date/shamsi_date.dart';

class DateUtil {
  static String formatLocaleDate(dynamic item, context) {
    if (item == null || item.toString().isEmpty) return "";
    final date = DateTime.tryParse(item.toString());
    if (date == null) return item.toString();
    if (Language.isRtl(context)) {
      final j = Jalali.fromDateTime(date);
      final f = j.formatter;
      return "${f.yyyy}/${f.mm}/${f.dd}";
    }
    return DateFormat("yyyy-MM-dd").format(date);
  }

  /// Converts the text shown in a date field to a gregorian `yyyy-MM-dd` string.
  static String toGregorianString(String text, BuildContext context) {
    if (Language.isRtl(context)) {
      final parts = text.split('/');
      if (parts.length == 3) {
        final y = int.tryParse(parts[0]);
        final m = int.tryParse(parts[1]);
        final d = int.tryParse(parts[2]);
        if (y != null && m != null && d != null) {
          return DateFormat("yyyy-MM-dd").format(Jalali(y, m, d).toDateTime());
        }
      }
    }
    return text;
  }

  /// Shows the proper (Persian / Gregorian) date picker and writes the result to [controller].
  static Future<void> pickDate(
      BuildContext context, TextEditingController controller) async {
    if (Language.isRtl(context)) {
      final picked = await showPersianDatePicker(
        context: context,
        initialDate: Jalali.now(),
        firstDate: Jalali(1385, 1, 1),
        lastDate: Jalali(1450, 12, 29),
      );
      if (picked != null) {
        final f = picked.formatter;
        controller.text = "${f.yyyy}/${f.mm}/${f.dd}";
      }
    } else {
      final picked = await showDatePicker(
        context: context,
        initialDate: DateTime.tryParse(controller.text) ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );
      if (picked != null) {
        controller.text = DateFormat("yyyy-MM-dd").format(picked);
      }
    }
  }
}
