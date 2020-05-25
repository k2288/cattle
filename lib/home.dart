import 'package:barcode_scan/platform_wrapper.dart';
import 'package:cattle/components/dashboard/dashboard.dart';
import 'package:cattle/components/newAnimal/new-animal.dart';
import 'package:cattle/widgets/fab_bottom_navigation/fab_bottom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        
        actions: <Widget>[
            IconButton(icon: Icon(Icons.notifications_none,color: Colors.white,), onPressed: ()=>{}),
            IconButton(icon: Icon(FontAwesomeIcons.qrcode,color: Colors.white,), onPressed: _scaneBarcode),
          ],
        title: Text("نام مجموعه"),
      ),
      body: Dashboard(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => NewAnimal())); },
        tooltip: 'Increment',
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
      bottomNavigationBar: FabBottomAppBar(
        selectedColor: Theme.of(context).primaryColor,
        color: Colors.grey[500],
        onTabSelected: _onItemTapped,
        items: [
          FABBottomAppBarItem(iconData: Icons.dashboard, text: ''),
          FABBottomAppBarItem(iconData: Icons.message, text: ''),
          FABBottomAppBarItem(iconData:null, text: ""),
          FABBottomAppBarItem(iconData: FontAwesomeIcons.userNurse, text: ''),
          FABBottomAppBarItem(iconData: Icons.settings, text: ''),
        ],
      ),

    );
  }

  _scaneBarcode() async {
    var result = await BarcodeScanner.scan();
    print(result.rawContent);

  }
}
