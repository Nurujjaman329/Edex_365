import 'package:intl/intl.dart';

class Formatter{

  static String date(DateTime date){
    final dateFormat = new DateFormat('yyyy-MM-dd');
    return dateFormat.format(date);
  }
}