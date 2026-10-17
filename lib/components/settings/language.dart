import 'package:cattle/models/LocaleModel.dart';
import 'package:flutter/material.dart';
import 'package:cattle/l10n/app_localizations.dart';
import 'package:settings_ui/settings_ui.dart';

class ChangeLanguagePage extends StatelessWidget {

  final List<Language> _languageList;
  final Function _chooseLanguage;

  const ChangeLanguagePage(this._languageList,this._chooseLanguage, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.setting_language),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text(''),
            tiles: _languageList.map<SettingsTile>((e) {
              return SettingsTile(
                title: Text(e.name),
                onPressed: (context) {
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