import 'package:cattle/components/dashboard/main_dashboard_card.dart';
import 'package:cattle/components/dashboard/summary_card.dart';
import 'package:cattle/components/list/filter.dart';
import 'package:cattle/components/list/list.dart';
import 'package:cattle/models/Dashboard.dart';
import 'package:cattle/repositories/DashboardRespository.dart';
import 'package:cattle/utils/api/Response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  DashboardRespository _dashboardRespository;

  _DashboardState(){
    _dashboardRespository=DashboardRespository();
  }

  DashboardData _dashboard=DashboardData();

  EdgeInsetsGeometry _topBottomPadding=EdgeInsets.only(
    top:15.0,
    bottom:15.0
  );


  @override
  void initState() {
    getData();
    super.initState();
    
  }

  Future<void> getData()async{
    var response=await _dashboardRespository.getDashboard();
    if(response.status==Status.COMPLETED){
      
      setState(() {
        _dashboard=response.data;  
      });
      
    }else{
      Scaffold
        .of(context)
        .showSnackBar(SnackBar(
            content: Text(response.message,style: TextStyle(color: Colors.white,fontFamily: "Iran_Sans"),),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          )
        );
    }

  }

  @override
  Widget build(BuildContext context) {

    return RefreshIndicator(child: CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
          padding: EdgeInsets.only(
            left: 15.0,
            right: 15.0
          ),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              GridView.count(
                padding: _topBottomPadding,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: <Widget>[
                  MainDashboardCard(Color(0xfffd6768),_dashboard.total.toString().padLeft(2,"0") ,AppLocalizations.of(context).dashboard_total_animal,"assets/images/total_cow.svg",()=>_onMainCardClick(FilterData([], []))),
                  MainDashboardCard(Color(0xff109da4),_dashboard.calved.toString().padLeft(2,"0"),AppLocalizations.of(context).dashboard_milking_cow,"assets/images/milking_cow.svg",()=>_onMainCardClick(FilterData(["CALVED"], []))),
                  MainDashboardCard(Color(0xfff0981a),_dashboard.dry.toString().padLeft(2,"0"),AppLocalizations.of(context).dashboard_dry_cow,"assets/images/dry_cow.svg",()=>_onMainCardClick(FilterData(["DRY"],[]))),
                  MainDashboardCard(Color(0xff48294b),"00.00",AppLocalizations.of(context).dashboard_avg_milk,"assets/images/milk.svg",null),
                ],
              ),
              Text(AppLocalizations.of(context).dashboard_summary,style: Theme.of(context).textTheme.headline6),
              GridView.count(
                crossAxisCount: 3,
                padding: _topBottomPadding,
                // crossAxisSpacing: 2,
                // mainAxisSpacing: 2,
                childAspectRatio: 4/3,                
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  SummaryCard(0,AppLocalizations.of(context).dashboard_insemination, _dashboard.insemination.toString().padLeft(2,"0"),()=>_onMainCardClick(FilterData(["INSEMINATION"], []))),
                  SummaryCard(1,AppLocalizations.of(context).dashboard_milked, _dashboard.milked.toString().padLeft(2,"0"),()=>_onMainCardClick(FilterData(["MILKED"], []))),
                  SummaryCard(2,AppLocalizations.of(context).dashboard_heifer, _dashboard.heifer.toString().padLeft(2,"0"),()=>_onMainCardClick(FilterData(["HEIFER"], []))),
                  SummaryCard(3,AppLocalizations.of(context).dashboard_abortion, _dashboard.abortion.toString().padLeft(2,"0"),()=>_onMainCardClick(FilterData(["ABORTION"], []))),
                  SummaryCard(4,AppLocalizations.of(context).dashboard_bull, _dashboard.bull.toString().padLeft(2,"0"),()=>_onMainCardClick(FilterData([], ["BULL"]))),
                  SummaryCard(5,AppLocalizations.of(context).dashboard_cow, _dashboard.cow.toString().padLeft(2,"0"),()=>_onMainCardClick(FilterData([], ["COW"]))),
                ],
              )
            ]),
          ),
        )
      ],
    ), onRefresh: getData);
    
  }

  _onMainCardClick(FilterData filterDate){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CattleList(title: AppLocalizations.of(context).list_animals,filterData: filterDate,)),
    );
  }
}