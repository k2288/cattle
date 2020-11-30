import 'package:cattle/models/LocaleModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:settings_ui/settings_ui.dart';

class ChangeLanguagePage extends StatelessWidget {

  List<Language> _languageList;
  Function _chooseLanguage;

  ChangeLanguagePage(this._languageList,this._chooseLanguage);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).setting_language),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: '',
            tiles: _languageList.map<SettingsTile>((e) {
              return SettingsTile(
                title: e.name,
                onTap: () {
                  _chooseLanguage(e);
                  Navigator.pop(context);
                },
              );
            }).toList()
          ),
        ],
      ),
    );
  }
}