import 'package:flutter/cupertino.dart';
import 'package:new_wallpaper/Component/DetailIcon.dart';
import 'package:flutter/material.dart';
import 'package:new_wallpaper/Provider/PhotoFavorite.dart';
import 'package:share/share.dart';
import 'package:new_wallpaper/Component/File_Downloder.dart';
import 'package:new_wallpaper/localization/language.dart';
import 'package:new_wallpaper/theme/style.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class DetailScreen extends StatelessWidget {
  final image;

  DetailScreen({this.image});

  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false);
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
        decoration: BoxDecoration(
            image:
                DecorationImage(image: NetworkImage(image), fit: BoxFit.fill)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back_ios_outlined),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DetailIcon(
                  onTap: () {
                    Share.share(image, subject: 'NewPaper');
                  },
                  text: language.words['share'],
                  icon: Icon(
                    Icons.share_outlined,
                    size: 30,
                    color: Colors.grey[300],
                  ),
                ),
                FileDownloadWidget(url: image),
                FutureBuilder(
                    future: Provider.of<SLocalStorage>(context, listen: false)
                        .fetchLoveList(),
                    builder: (ctx, snap) =>
                        snap.connectionState == ConnectionState.waiting
                            ? Center(child: CircularProgressIndicator())
                            : DetailIcon(
                                text: language.words['download'],
                                bgColor: AppTheme.green,
                                icon: Consumer<SLocalStorage>(
                                    builder: (ctx, love, _) => GestureDetector(
                                        onTap: () {
                                          if (love.courseList.contains(image)) {
                                            love.removeCourse(url: image);
                                          } else {
                                            love.addToLoveList(photo: image);
                                          }
                                        },
                                        child: love.courseList.isEmpty
                                            ? Icon(
                                                Icons.favorite_border,
                                                color: AppTheme.black2,
                                                size: 30,
                                              )
                                            : love.courseList.contains(image)
                                                ? Icon(
                                                    Icons.favorite,
                                                    color: AppTheme.black2,
                                                    size: 30,
                                                  )
                                                : Icon(
                                                    Icons.favorite_border,
                                                    color: AppTheme.black2,
                                                    size: 30,
                                                  )))))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
