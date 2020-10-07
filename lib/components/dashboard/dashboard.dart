import 'package:cattle/components/dashboard/main_dashboard_card.dart';
import 'package:cattle/components/dashboard/summary_card.dart';
import 'package:cattle/components/list/filter.dart';
import 'package:cattle/components/list/list.dart';
import 'package:cattle/models/Dashboard.dart';
import 'package:cattle/repositories/DashboardRespository.dart';
import 'package:cattle/utils/api/Response.dart';
import 'package:flutter/material.dart';

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
    // TODO: implement initState
    super.initState();
    getData();
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
                  MainDashboardCard(Color(0xfffd6768),_dashboard.total.toString().padLeft(2,"0") ,"تعداد حیوانات","assets/images/total_cow.svg",()=>_onMainCardClick(FilterData([], []))),
                  MainDashboardCard(Color(0xff109da4),_dashboard.calved.toString().padLeft(2,"0"),"گاوهای شیری","assets/images/milking_cow.svg",()=>_onMainCardClick(FilterData(["زایش"], []))),
                  MainDashboardCard(Color(0xfff0981a),_dashboard.dry.toString().padLeft(2,"0"),"گاوهای خشک","assets/images/dry_cow.svg",()=>_onMainCardClick(FilterData(["خشک"],[]))),
                  MainDashboardCard(Color(0xff48294b),"00.00"," میانگین شیر/گاو (Kg)","assets/images/milk.svg",null),
                ],
              ),
              Text("خلاصه وضعیت",style: Theme.of(context).textTheme.title),
              GridView.count(
                crossAxisCount: 3,
                padding: _topBottomPadding,
                // crossAxisSpacing: 2,
                // mainAxisSpacing: 2,
                childAspectRatio: 4/3,                
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  SummaryCard(0,"تلقیح", _dashboard.insemination.toString().padLeft(2,"0"),()=>_onMainCardClick(FilterData(["تلقیح"], []))),
                  SummaryCard(1,"شیرخوار", _dashboard.milked.toString().padLeft(2,"0"),()=>_onMainCardClick(FilterData(["شیرخوار"], []))),
                  SummaryCard(2,'تلیسه', _dashboard.heifer.toString().padLeft(2,"0"),()=>_onMainCardClick(FilterData(["تلیسه"], []))),
                  SummaryCard(3,'سقط', _dashboard.abortion.toString().padLeft(2,"0"),()=>_onMainCardClick(FilterData(["سقط"], []))),
                  SummaryCard(4,"نر", _dashboard.bull.toString().padLeft(2,"0"),()=>_onMainCardClick(FilterData([], ["نر"]))),
                  SummaryCard(5,"ماده", _dashboard.cow.toString().padLeft(2,"0"),()=>_onMainCardClick(FilterData([], ["ماده"]))),
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
      MaterialPageRoute(builder: (context) => CattleList(title: "حیوانات",filterData: filterDate,)),
    );
  }
}