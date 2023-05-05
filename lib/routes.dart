import 'package:calendar/screens/Calendar/Calendar.dart';
import 'package:calendar/screens/Settings/Settings.dart';
import 'package:calendar/screens/auth/Login.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  Login.route: (context) => const Login(),
  Calendar.route: (context) => const Calendar(),
  Settings.route: (context) => const Settings(),
};
