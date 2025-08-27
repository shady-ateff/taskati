import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

TimeOfDay stringToTimeOfDay(String timeString) {
  // استبدل أي مسافات غريبة بمسافة عادية
  final cleaned = timeString.replaceAll(RegExp(r'\s+'), ' ').trim();

  final format = DateFormat("hh:mm a"); // "03:22 PM"
  final dateTime = format.parse(cleaned);

  return TimeOfDay.fromDateTime(dateTime);
}

