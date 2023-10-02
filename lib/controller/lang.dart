import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../enums.dart';

class Language extends ChangeNotifier {
  static CurrentLang currentLang = CurrentLang.en;

  static set setCurrentLang(CurrentLang current) {
    currentLang = current;
  }
}
