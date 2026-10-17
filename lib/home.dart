import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:cattle/components/dashboard/dashboard.dart';
import 'package:cattle/components/newAnimal/new-animal.dart';
import 'package:cattle/components/settings/settings.dart';
import 'package:cattle/widgets/fab_bottom_navigation/fab_bottom_app_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // int _selectedIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  void _onItemTapped(int index) {
    // _pageController.animateToPage(index,duration: Duration(milliseconds: 400),curve: Curves.easeInOut);
    _pageController.jumpToPage(index);
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
            IconButton(icon: Icon(Icons.notifications_none,color: Colors.white,), onPressed: ()=>{}),
            IconButton(icon: Icon(Icons.qr_code,color: Colors.white,), onPressed: _scaneBarcode),
          ],
        title: Text(" "),
      ),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Center(
            child: Container(
              child: Dashboard(),
            ),
          ),
          Center(
            child: Container(
              child: Text('Coming Soon'),
            ),
          ),
          Center(
            child: Container(
              child: Text(''),
            ),
          ),
          Center(
            child: Container(
              child: Text('Coming Soon'),
            ),
          ),
          Center(
            child: Container(
              child: Settings(),
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => NewAnimal())); },
        tooltip: '',
        elevation: 2.0,
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: FabBottomAppBar(
        selectedColor: Theme.of(context).primaryColor,
        color: Colors.grey.shade500,
        onTabSelected: _onItemTapped,
        items: [
          FABBottomAppBarItem(iconData: Icons.dashboard, text: ''),
          FABBottomAppBarItem(iconData: Icons.message, text: ''),
          FABBottomAppBarItem(text: ""),
          FABBottomAppBarItem(iconData: Icons.medical_services, text: ''),
          FABBottomAppBarItem(iconData: Icons.settings, text: ''),
        ],
      ),

    );
  }

  _scaneBarcode() async {
    // Minimal scanner: opens a MobileScanner page and prints the first code.
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(),
          body: MobileScanner(
            onDetect: (capture) {
              final codes = capture.barcodes;
              if (codes.isNotEmpty) {
                Navigator.pop(context, codes.first.rawValue);
              }
            },
          ),
        ),
      ),
    );
    debugPrint(result);

  }
}
