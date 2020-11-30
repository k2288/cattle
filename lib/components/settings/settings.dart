import 'package:cattle/components/login/login_page.dart';
import 'package:cattle/components/settings/language.dart';
import 'package:cattle/models/LocaleModel.dart';
import 'package:cattle/utils/api/ApiProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return SettingsList(
        sections: [
          SettingsSection(
            title: AppLocalizations.of(context).setting_common_section,
            tiles: [
              SettingsTile(
                title: AppLocalizations.of(context).setting_language,
                subtitle: languageList.where((Language element) =>element.code==Localizations.localeOf(context).languageCode).first.name,
                leading: Icon(Icons.language),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangeLanguagePage(languageList,(e)=>Provider.of<LocaleModel>(context, listen: false).set(e.code))));
                },
              ),
              SettingsTile(
                title:AppLocalizations.of(context).setting_sign_out,
                leading: Icon(Icons.exit_to_app),
                onTap: () {
                  ApiProvider().emptyToken();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                },
              ),
            ],
          ),
        ],
      );
  }
}