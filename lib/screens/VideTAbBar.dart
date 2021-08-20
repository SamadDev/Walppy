import 'package:flutter/material.dart';
import 'package:new_wallpaper/localization/language.dart';
import 'package:new_wallpaper/screens/DrawerScreen.dart';
import 'package:new_wallpaper/screens/HomeVideoScreen.dart';
import 'package:provider/provider.dart';

class VideoTbaBAr extends StatelessWidget {
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false);
    return DefaultTabController(
      length: 15,
      child: Scaffold(
          drawer: DrawerScreen(),
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                new SliverAppBar(
                  actions: [Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/images/search.png',width: 25,height: 2,color: Theme.of(context).buttonColor,),
                  ),
                  ],
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
                HomeVideoScreen(remove: false, category: 'all'),
                HomeVideoScreen(remove: false, category: 'nature'),
                HomeVideoScreen(remove: false, category: 'technology'),
                HomeVideoScreen(remove: false, category: 'programing',),
                HomeVideoScreen(remove: false, category: 'animal',),
                HomeVideoScreen(remove: false, category: "fashion",),
                HomeVideoScreen(remove: false, category: "baby",),
                HomeVideoScreen(remove: false, category: 'travel',),
                HomeVideoScreen(remove: false, category: "moon",),
                HomeVideoScreen(remove: false, category: 'flag',),
                HomeVideoScreen(remove: false, category: 'architecture',),
                HomeVideoScreen(remove: false, category: 'laptop'),
                HomeVideoScreen(remove: false, category: "programing"),
                HomeVideoScreen(remove: false, category: 'health & wealth'),
                HomeVideoScreen(remove: false, category: 'culture'),
              ],
            ),
          )),
    );
  }
}
