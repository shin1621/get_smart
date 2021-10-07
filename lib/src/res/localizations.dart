import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_smart/get_smart.dart';
import 'package:intl/number_symbols.dart';
import 'package:intl/number_symbols_data.dart';

/// Platform localization to add multi-language support
/// * Usage
/// ```
///   [
///     GetLocalization.delegate,
///     GlobalMaterialLocalizations.delegate,
///     GlobalWidgetsLocalizations.delegate,
///   ];
/// ```
class GetLocalizations {
  static const english = const Locale('en', '');
  static const supportedLocales = [GetLocalizations.english];

  static const GetLocalizationsDelegate delegate =
      const GetLocalizationsDelegate();

  GetLocalizations(this.locale)
      : symbols = numberFormatSymbols[locale.toString()];

  final Locale locale;
  final NumberSymbols symbols;

  static GetLocalizations? get current {
    return Localizations.of<GetLocalizations>(Get.context!, GetLocalizations);
  }
}

/// Platform localization delegate to trigger language change in the device
class GetLocalizationsDelegate extends LocalizationsDelegate<GetLocalizations> {
  const GetLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      GetLocalizations.supportedLocales.contains(locale);

  @override
  Future<GetLocalizations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of Localization.
    return SynchronousFuture<GetLocalizations>(GetLocalizations(locale));
  }

  @override
  bool shouldReload(GetLocalizationsDelegate old) => false;
}
