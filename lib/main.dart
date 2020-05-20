import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

import './common/routes/Routers.dart';
import 'common/blocs/ThemeChanger.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main(){
    HttpOverrides.global = new MyHttpOverrides();
    runApp(new MesanMobile());
}

class MesanMobile extends StatelessWidget {
  //final GlobalBloc _globalBloc = GlobalBloc();
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData (
        fontFamily: 'OpenSans',
        primaryColor: white,
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.red
      ),
      initialRoute: authenticationRoute,
      onGenerateRoute: Router.generateRoute,
      );
  }
}

// class MaterialAppWithTheme extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final theme = Provider.of<ThemeChanger>(context);
//     return MaterialApp(
//       theme: theme.getTheme(),
//       home: MainScreen(),
//       );
//   }
// }
