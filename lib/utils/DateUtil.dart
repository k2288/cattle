import 'package:cattle/models/LocaleModel.dart';
import 'package:intl/intl.dart';
import 'package:persian_date/persian_date.dart';

class DateUtil{
  static formatLocaleDate(item,context){
      return Language.isRtl(context)? PersianDate().gregorianToJalali(item,"yyyy/mm/d"): DateFormat("yyyy-MM-dd").format(DateTime.parse(item));
  }
}