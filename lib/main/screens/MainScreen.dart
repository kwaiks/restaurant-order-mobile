import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mesan_mobile/common/widgets/FABar.dart';
import 'package:toast/toast.dart';
//import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../../common/routes/Routers.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String barcodeString;
  int _currentIndex = 0;
  DateTime currentBackPressTime;
  final List<Widget> _children = [
    homeFragment, 
    historyFragment, 
    inboxFragment, 
    acccountFragment
  ];
  final List<FABBottomAppBarItem> _bottomBarItems = [
    FABBottomAppBarItem(iconData: MdiIcons.home, text: 'Home'),
    FABBottomAppBarItem(iconData: MdiIcons.receipt, text: 'History'),
    FABBottomAppBarItem(iconData: MdiIcons.messageText, text: 'Inbox'),
    FABBottomAppBarItem(iconData: MdiIcons.account, text: 'Account'),
  ];
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
          child: Scaffold(
            body: _children[_currentIndex],
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: (){},
              tooltip: 'Increment',
              backgroundColor: Colors.red,
              child: Icon(MdiIcons.qrcodeScan),
              elevation: 2.0,
            ),
            bottomNavigationBar: FABNavigationBar(
            onTabSelected: onTabTapped,
            centerItemText: 'Scan',
            selectedColor: Colors.redAccent,
            items: _bottomBarItems,
          ),
        ),
    );
  }

  //Scan Barcode Function
  // Future scan() async {
  //   try {
  //     String barcode = await FlutterBarcodeScanner.scanBarcode(
  //         "#ff6666", "Back", true, ScanMode.QR);
  //     setState(() => this.barcodeString = barcode);
  //   } on FormatException {} catch (e) {}
  // }

  //Prevent user from closing application when press back button for 2 seconds
  Future<bool> onWillPop() async {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Toast.show("Press once again to exit app", context,
          duration: 2, gravity: Toast.BOTTOM, backgroundRadius: 10);
      return false;
    }
    return SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  //Navigatior
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}