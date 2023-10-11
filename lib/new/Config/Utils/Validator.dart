import 'package:shakosh/new/Config/Translations/Translation.dart';

class Validators {
  String? validEmpty(String? val) {
    if (val!.trim().isEmpty) {
      return "valid-empty".tr;
    }
    return null;
  }

  String? validPassword(String? val) {
    if (val!.trim().isEmpty) {
      return "valid-empty".tr;
    } else if (val.trim().length < 6) {
      return "valid-length-6".tr;
    }
    return null;
  }

    String? validPhone(String? val) {
    if (val!.trim().isEmpty) {
      return "valid-empty".tr;
    } else if (val.trim().length < 11) {
      return "valid-length-11".tr;
    }
    return null;
  }

  String? validConfirmPassword(String? val1, String? val2) {
    if (val2!.trim().isEmpty) {
      return "valid-empty".tr;
    } else if (val1!.trim() != val2.trim()) {
      return "valid-confirm-two-fields".tr;
    }
    return null;
  }
}
