import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

class Custom_Theme{
  final box=GetStorage();
  final key="isDarkMode";
  bool get_theme_mode()=>box.read(key)??false;
  save_theme_mode(bool isDarkMode)=>box.write(key, isDarkMode);
  ThemeMode get theme=>get_theme_mode() ?ThemeMode.dark:ThemeMode.light;
  void switch_theme(){
    Get.changeThemeMode(get_theme_mode()?ThemeMode.light:ThemeMode.dark);
    save_theme_mode(!get_theme_mode());
  }
}