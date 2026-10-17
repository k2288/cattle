import 'dart:convert';

import 'package:cattle/models/LocaleModel.dart';
import 'package:cattle/utils/SettingsProvider.dart';
import 'package:flutter/material.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:cattle/l10n/app_localizations.dart';

class Filter extends StatefulWidget {

  final FilterData _data;

  const Filter(this._data, {super.key});

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {

  FilterData data=FilterData([],[]);

  @override
  void initState() {
    data=widget._data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child:  Container(
      padding: EdgeInsets.all(20),
      child:  Column(
          children: [
            Align(
              alignment: Language.isRtl(context) ? Alignment.centerRight:Alignment.centerLeft,
              child: Text(AppLocalizations.of(context)!.filter_state,style: Theme.of(context).textTheme.displaySmall),
            ),

            Align(
              alignment: Alignment.centerRight,
              child: ChipsChoice<String>.multiple(
                value: data.states ,
                choiceItems: C2Choice.listFrom<String, SettingValueTitle>(
                  source: SettingsProvider().getSettings().livestockState ?? <SettingValueTitle>[],
                  value: (i, v) => v.value,
                  label: (i, v) => jsonDecode(v.title)[Localizations.localeOf(context).languageCode].toString(),
                ),
                onChanged: (val) => setState(() => data.states = val),
                wrapped: true,

              ),
            ),
            // SizedBox(height: 10,),
            Align(
              alignment: Language.isRtl(context) ? Alignment.centerRight:Alignment.centerLeft,
              child: Text(AppLocalizations.of(context)!.filter_gender,style: Theme.of(context).textTheme.displaySmall),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ChipsChoice<String>.multiple(
                value: data.type ,
                choiceItems: C2Choice.listFrom<String, SettingValueTitle>(
                  source: SettingsProvider().getSettings().livestockType ?? <SettingValueTitle>[],
                  value: (i, v) => v.value,
                  label: (i, v) => jsonDecode(v.title)[Localizations.localeOf(context).languageCode].toString(),
                ),
                onChanged: (val) => setState(() => data.type = val),
                wrapped: true,

              ),
            ),
            OverflowBar(
              overflowSpacing: 20,
              spacing: 20,
              alignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, foregroundColor: Colors.white, padding: EdgeInsets.all(10)),
                  onPressed: (){
                    Navigator.of(context).pop(data);
                  },
                  child: Text(AppLocalizations.of(context)!.filter_confirm,style: TextStyle(fontSize: 15),),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, foregroundColor: Colors.white, padding: EdgeInsets.all(10)),
                  onPressed: (){
                    Navigator.of(context).pop(FilterData([],[]));
                  },
                  child: Text(AppLocalizations.of(context)!.filter_clear,style: TextStyle(fontSize: 15),),
                )
              ],
            )
          ],
        )
      ),
    );
  }
        
}

class FilterData{
  List<String> states=[] ;
  List<String> type=[] ;

  FilterData(this.states,this.type);

}