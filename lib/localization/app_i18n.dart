import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_localizations/flutter_localizations.dart';

class Appi18n {
  Appi18n(String localeName) : this.localeName = localeName;

  final String localeName;
  static Map<String, dynamic> _localizedValues = {};

  static Appi18n? of(BuildContext context) {
    return Localizations.of<Appi18n>(context, Appi18n);
  }

  String getValue(String key) {
    return _localizedValues[key] ?? '** $key not found';
  }

  String operator [](String key) {
    return getValue(key);
  }

  static Future<Appi18n> load(Locale locale) async {
    Appi18n translations = new Appi18n(locale.languageCode);
    String jsonContent = await rootBundle
        .loadString("assets/i18n/app_${locale.languageCode}.json");
    _localizedValues = json.decode(jsonContent);
    return translations;
  }

  static const LocalizationsDelegate<Appi18n> delegate = _Appi18nDelegate();
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi')
  ];
}

class _Appi18nDelegate extends LocalizationsDelegate<Appi18n> {
  const _Appi18nDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'vi'].contains(locale.languageCode);

  @override
  Future<Appi18n> load(Locale locale) => Appi18n.load(locale);

  @override
  bool shouldReload(_Appi18nDelegate old) => false;
}
