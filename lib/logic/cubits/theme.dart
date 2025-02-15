import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/data/providers/hive_storage.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(HiveStorageService().getThemeMode());

  void setThemeMode(ThemeMode themeMode) {
    HiveStorageService().saveThemeMode(themeMode);
    emit(themeMode);
  }
}
