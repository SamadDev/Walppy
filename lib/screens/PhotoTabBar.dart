import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_wallpaper/localization/language.dart';
import 'package:new_wallpaper/screens/DrawerScreen.dart';
import 'package:new_wallpaper/screens/Home_Screen.dart';
import 'package:provider/provider.dart';

class Tab_Bar extends StatelessWidget {
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false);
    return DefaultTabController(
      length: 15,
      child: Scaffold(
          drawer: DrawerScreen(),
          body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder:
                (context, bool innerBoxIsScrolled) {
              return <Widget>[
                new SliverAppBar(
                  toolbarHeight: 70,

                  actions: [Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/images/search.png',width: 25,height: 2,color: Theme.of(context).buttonColor,),
                  ),
                  ],
                  primary: true,
                  snap: true,
                  backgroundColor: Theme.of(context).cardColor,
                  pinned: true,
                  stretch: true,
                  automaticallyImplyLeading: true,
                  backwardsCompatibility: true,
                  centerTitle: true,
                  excludeHeaderSemantics: true,
                  forceElevated: true,
                  floating: true,
                  bottom: TabBar(
                    onTap: (int) {},
                    isScrollable: true,
                    tabs: [
                      Tab(child: Text(language.words['all'])),
                      Tab(child: Text(language.words['nature'])),
                      Tab(child: Text(language.words['technology'])),
                      Tab(child: Text(language.words['programing']),),
                      Tab(child: Text(language.words['animal'])),
                      Tab(child: Text(language.words['fashion'])),
                      Tab(child: Text(language.words['baby'])),
                      Tab(child: Text(language.words['travel'])),
                      Tab(child: Text(language.words['moon'])),
                      Tab(child: Text(language.words['flag'])),
                      Tab(child: Text(language.words['architecture'])),
                      Tab(child: Text(language.words['laptop'])),
                      Tab(child: Text(language.words['programing']),),
                      Tab(child: Text(language.words['health & wealth'])),
                      Tab(child: Text(language.words['culture'])),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: <Widget>[
                HomeScreen(remove: false, category: 'all'),
                HomeScreen(remove: false, category: 'nature'),
                HomeScreen(remove: false, category: 'technology'),
                HomeScreen(remove: false, category: 'programing',),
                HomeScreen(remove: false, category: 'animal',),
                HomeScreen(remove: false, category: "fashion",),
                HomeScreen(remove: false, category: "baby",),
                HomeScreen(remove: false, category: 'travel',),
                HomeScreen(remove: false, category: "moon",),
                HomeScreen(remove: false, category: 'flag',),
                HomeScreen(remove: false, category: 'architecture',),
                HomeScreen(remove: false, category: 'laptop'),
                HomeScreen(remove: false, category: "programing"),
                HomeScreen(remove: false, category: 'health & wealth'),
                HomeScreen(remove: false, category: 'culture'),
              ],
            ),
          )),
    );
  }
}
