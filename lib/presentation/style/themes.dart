import 'package:flutter/material.dart';
import 'package:semi/presentation/style/colors.dart';
import 'package:sizer/sizer.dart';

final ThemeData lightTheme = ThemeData(
  primaryColor: AppColor.kWhite,
  textTheme: TextTheme(button: TextStyle(color: Colors.white70)),
  brightness: Brightness.light,
);
final ThemeData darkTheme = ThemeData(
  primaryColor: AppColor.kBackground,
  textTheme: TextTheme(button: TextStyle(color: Colors.black54)),
  brightness: Brightness.dark,
);
