import 'dart:ui';

import 'package:Flutter_BoilerPlate_With_Auth/core/enums/language.dart';
import 'package:flutter/foundation.dart';

class LanguageHelper {
  static String getFlagDescriptionForLanguage(Language language) {
    return language == Language.EN ? "GB" : describeEnum(language);
  }

  static Locale getLocaleForLanguage(Language language) {
    var langString = describeEnum(language).toLowerCase();
    return Locale.fromSubtags(languageCode: langString);
  }
}
