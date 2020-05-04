import 'package:cattle/components/dashboard/main_dashboard_card.dart';
import 'package:cattle/components/dashboard/summary_card.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  EdgeInsetsGeometry _topBottomPadding=EdgeInsets.only(
    top:15.0,
    bottom:15.0
  );

  @override
  Widget build(BuildContext context) {

    return CustomScrollView(
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
                  MainDashboardCard(Color(0xfffd6768),"15","تعداد حیوانات","assets/images/total_cow.svg"),
                  MainDashboardCard(Color(0xff109da4),"08","گاوهای شیری","assets/images/milking_cow.svg"),
                  MainDashboardCard(Color(0xfff0981a),"02","گاوهای خشک","assets/images/dry_cow.svg"),
                  MainDashboardCard(Color(0xff48294b),"20.00"," میانگین شیر/گاو (Kg)","assets/images/milk.svg"),
                ],
              ),
              Text("خلاصه باروری",style: Theme.of(context).textTheme.title),
              GridView.count(
                crossAxisCount: 3,
                padding: _topBottomPadding,
                // crossAxisSpacing: 2,
                // mainAxisSpacing: 2,
                childAspectRatio: 4/3,                
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  SummaryCard(0,"آماده تلقیح",555),
                  SummaryCard(1,"حامله",3),
                  SummaryCard(2,'بارداری منفی',5),
                  SummaryCard(3,'خشک',1),
                  SummaryCard(4,"عقیم",0),
                  SummaryCard(5,"بدون فحلی",2),
                ],
              )
            ]),
          ),
        )
      ],
    );
  }
}