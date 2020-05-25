import 'package:cattle/components/detail/detail_card_actions.dart';
import 'package:cattle/components/detail/milk_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 300.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset("assets/images/cow.jpeg"),
            ),
          ),
          SliverPadding(padding: EdgeInsets.all(20),
            sliver:SliverList(   
              delegate: SliverChildListDelegate(
                [

                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("فحلی",style: Theme.of(context).textTheme.display3,),
                      ),
                      Text("100" , style: Theme.of(context).textTheme.display4,),
                      Padding(
                        child: Icon(FontAwesomeIcons.tag,color: Colors.yellow,),
                        padding: EdgeInsets.only(left:5,right:5,bottom:5),
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("ماده | ۱سال‌و۶ماه",style: Theme.of(context).textTheme.display4,),
                      ),
                      
                      Padding(
                        child: SvgPicture.asset("assets/images/milk.svg",fit:BoxFit.cover,height: 25,),
                        padding: EdgeInsets.only(left:5,right:5,bottom:5),
                      ),
                      Text("90 روز" , style: Theme.of(context).textTheme.display4,),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    // color: Colors.red,
                    height: 140,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        DetailCardAction(Color(0xfffeddda), _onActionClick, "ثبت شیر", "assets/images/milking.svg",Color(0xffd34622)),  
                        DetailCardAction(Color(0xffded9fb), _onActionClick, "ثبت تلقیح", "assets/images/fertilization.svg",Color(0xff583fe4)),
                        DetailCardAction(Color(0xffc9f7f3), _onActionClick, "ثبت سلامتی", "assets/images/heart.svg",Color(0xff00d6c2)),
                        // DetailCardAction(Color(0xfffeddda), _onActionClick, "ثبت شیر", "assets/images/milking.svg",Color(0xffd34622)),
                      ],
                    ),
                  ),
                  MilkChart(_createSampleData()),
                  
                  Container(color: Colors.orange),
                  Container(color: Colors.yellow),
                  Container(color: Colors.pink),
                ],
              ),
            ),
          ),
          
        ],
      ),
    );
  }

  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 5),
      new LinearSales(1, 25),
      new LinearSales(2, 100),
      new LinearSales(3, 75),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  _onActionClick(){

  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}