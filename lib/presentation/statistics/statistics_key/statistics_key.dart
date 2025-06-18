import 'package:flutter/material.dart';
import 'package:mongbi_app/presentation/statistics/widgets/custom_snack_bar.dart';
import 'package:mongbi_app/presentation/statistics/widgets/month_year_picker.dart';

final monthPickerButton = GlobalKey();
final yearPickerButton = GlobalKey();
final GlobalKey<MonthYearPickerState> monthPickerKey =
    GlobalKey<MonthYearPickerState>();
final GlobalKey<MonthYearPickerState> yearPickerKey =
    GlobalKey<MonthYearPickerState>();
final GlobalKey<CustomSnackBarState> monthSnackBarKey =
    GlobalKey<CustomSnackBarState>();
final GlobalKey<CustomSnackBarState> yearSnackBarKey =
    GlobalKey<CustomSnackBarState>();
