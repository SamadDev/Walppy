import 'package:new_wallpaper/localization/language.dart';
import 'package:new_wallpaper/module/Video.dart';
import 'package:new_wallpaper/screens/DetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import 'package:new_wallpaper/module/Pixel_module.dart';
import 'package:new_wallpaper/theme/style.dart';



class HomeScreen extends StatelessWidget {
  final String? category;
  final bool remove;

  HomeScreen({this.category, required this.remove});

  Widget build(BuildContext context) {
    int _index = 2;
    final data = Provider.of<Pixel>(context, listen: false);
    final language=Provider.of<Language>(context,listen:false);
    return Scaffold(
      body: FutureBuilder(
          future:
          data.getPhotos(category, _index, remove: remove),
          builder: (ctx, snap) =>
          snap.connectionState ==
              ConnectionState.waiting
              ? Center(child: CircularProgressIndicator())
              : Consumer<Pixel>(
              builder: (ctx, photo, _) =>
                  LazyLoadScrollView(
                    onEndOfPage: () {
                      Fluttertoast.showToast(
                          msg: language.words['message'],
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: AppTheme.green,
                          textColor: AppTheme.white,
                          fontSize: 16.0
                      );
                      _index = _index + 1;
                      data.getPhotos(category, _index, remove: true);
                    },
                    child: StaggeredGridView.countBuilder(
                      itemCount: photo.module!.photos!.length,
                      staggeredTileBuilder: (i) =>
                          StaggeredTile.count((i%7==0)?3:1,(i%7==0)?2:1),
                      mainAxisSpacing: 2.0,
                      crossAxisSpacing:2.0,
                      crossAxisCount: 4,
                      itemBuilder: (BuildContext context, i) =>
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) =>
                                      DetailScreen(
                                        image: photo.module!.photos![i].src!
                                            .large.toString(),)));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      width: 5, color: AppTheme.black4)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(
                                  photo.module!.photos![i].src!.large
                                      .toString(),
                                  fit: BoxFit.cover,
                                  // repeat: ImageRepeat.noRepeat,
                                ),
                              ),
                            ),
                          ),
                    ),
                  ))),
    );
  }
}



