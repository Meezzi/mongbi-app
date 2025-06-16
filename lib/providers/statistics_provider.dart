import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/presentation/statistics/models/picker_model.dart';
import 'package:mongbi_app/presentation/statistics/models/statistics_model.dart';
import 'package:mongbi_app/presentation/statistics/view_models/picker_view_model.dart';
import 'package:mongbi_app/presentation/statistics/view_models/statistics_view_model.dart';

final pickerViewModelProvider = NotifierProvider<PickerViewModel, PickerModel>(
  () {
    return PickerViewModel();
  },
);
