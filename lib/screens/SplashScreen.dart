// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:wallpaper/Provider/DarkMode.dart';
// import 'package:wallpaper/localization/language.dart';
// import 'package:wallpaper/screens/PhotoTabBar.dart';
//
// class SplashScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Future<void>loadData()async{
//     await Provider.of<Language>(context,listen:false).getLanguageDataInLocal();
//     await  Provider.of<DarkThemePreference>(context,listen:false).getTheme();
//     Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>Tab_Bar()));
//     }
//     return Scaffold(
//       body: FutureBuilder(
//         future: loadData(),
//           builder: (ctx, snap) => snap.connectionState == ConnectionState.waiting
//               ? CircularProgressIndicator()
//               : CircularProgressIndicator()),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:new_wallpaper/Provider/DarkMode.dart';
import 'package:new_wallpaper/localization/language.dart';
import 'package:new_wallpaper/screens/PhotoTabBar.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0),(){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Tab_Bar()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<Language>(context,listen:false).getLanguageDataInLocal();
    Provider.of<DarkThemePreference>(context,listen:false).getTheme();
    return  Center(child: CircularProgressIndicator());
  }
}
