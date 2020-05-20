// ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);

// Switch(value: isSwitched, 
//           onChanged: (value){
//             isSwitched = value;
//             if(value){
//               _themeChanger.setTheme(ThemeData.dark());
//             }else{
//               _themeChanger.setTheme(ThemeData.light());
//             }
//         })


// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import './main/screens/MainScreen.dart';
// import 'common/blocs/ThemeChanger.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
  
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<ThemeChanger>(
//           create: (_)=>ThemeChanger(ThemeData(
//             primaryColor: Colors.white
//           )),
//           child: MaterialAppWithTheme(),
//     );
//   }
// }

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
