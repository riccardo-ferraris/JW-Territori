import 'package:flutter/material.dart';

class MyDateParser {
  static dynamic dateInverter(String date) {
    List<String> dateSplitted = date.split('/');

    List<String> dateInverted = dateSplitted.reversed.toList();
    String year;
    String month;
    String day;
    if (dateInverted.length > 1) {
      year = dateInverted.elementAt(0);
      month = dateInverted.elementAt(1);
      day = dateInverted.elementAt(2);
      if (int.parse(month) < 10) month = '0$month';
      if (int.parse(day) < 10) day = '0$day';
      return DateTime.parse('$year-$month-$day');
    }
    return null;
  }

  static Color? cardColorFromDate(DateTime dataLimite) {
    DateTime now = DateTime.now();
    if (dataLimite.difference(now) < const Duration(days: 60) &&
        dataLimite.difference(now) > const Duration(days: 0)) {
      return Colors.yellow;
    } else if (dataLimite.difference(now).isNegative) {
      return Colors.red[600];
    } else {
      return Colors.white;
    }
  }
}
