import 'dart:convert';

import 'package:cattle/models/LocaleModel.dart';
import 'package:cattle/utils/SettingsProvider.dart';
import 'package:flutter/material.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Filter extends StatefulWidget {

  final FilterData _data;

  Filter(this._data);

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
              child: Text(AppLocalizations.of(context).filter_state,style: Theme.of(context).textTheme.headline3),
            ),

            Align(
              alignment: Alignment.centerRight,
              child: ChipsChoice<String>.multiple(
                value: data.states ,
                options: ChipsChoiceOption.listFrom<String, SettingValueTitle>(
                  source: SettingsProvider().getSettings().livestockState,
                  value: (i, v) => v.value,
                  label: (i, v) =>jsonDecode(v.title)[Localizations.localeOf(context).languageCode],
                ),
                onChanged: (val) => setState(() => data.states = val),
                isWrapped: true,

              ),
            ),
            // SizedBox(height: 10,),
            Align(
              alignment: Language.isRtl(context) ? Alignment.centerRight:Alignment.centerLeft,
              child: Text(AppLocalizations.of(context).filter_gender,style: Theme.of(context).textTheme.headline3),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ChipsChoice<String>.multiple(
                value: data.type ,
                options: ChipsChoiceOption.listFrom<String, SettingValueTitle>(
                  source: SettingsProvider().getSettings().livestockType,
                  value: (i, v) => v.value,
                  label: (i, v) => jsonDecode(v.title)[Localizations.localeOf(context).languageCode],
                ),
                onChanged: (val) => setState(() => data.type = val),
                isWrapped: true,

              ),
            ),
            ButtonBar(
              
              buttonPadding: EdgeInsets.all(20),
              alignment: MainAxisAlignment.spaceAround,
              children: [
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  padding: EdgeInsets.all(10),
                  
                  onPressed: (){
                    Navigator.of(context).pop(data);
                  },
                  child: Text(AppLocalizations.of(context).filter_confirm,style: TextStyle(fontSize: 15),),
                ),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  padding: EdgeInsets.all(10,),
                  
                  onPressed: (){
                    Navigator.of(context).pop(FilterData([],[]));
                  },
                  child: Text(AppLocalizations.of(context).filter_clear,style: TextStyle(fontSize: 15),),
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