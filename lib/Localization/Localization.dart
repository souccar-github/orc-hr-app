import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Localization {
  final Locale locale;

  Localization(this.locale);

  static Localization of(BuildContext context){
    return Localizations.of<Localization>(context,Localization);
  }

  Map<String,String> _localizedValues;

  Future load() async{
    String jsonStringValues = await rootBundle.loadString('lib/Langs/${locale.languageCode}.json');

    Map<String,dynamic> mappedJson = json.decode(jsonStringValues);

    _localizedValues = mappedJson.map((key, value) => MapEntry(key,value.toString()));
  }

  String getTranslatedValue(String key){
    return _localizedValues[key]??key;
  }

  static const LocalizationsDelegate<Localization> delegate =_LocalizationDelegate();

}

class _LocalizationDelegate extends LocalizationsDelegate<Localization>{
  const _LocalizationDelegate();
  @override
  bool isSupported(Locale locale) {
    return ['en','ar'].contains(locale.languageCode);
      }
  
    @override
    Future<Localization> load (Locale locale) async {
      Localization localization = new Localization(locale);
      await localization.load();
      return localization;
    }

  @override
  bool shouldReload(LocalizationsDelegate<Localization> old) => false;
}
