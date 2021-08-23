import 'package:flutter/material.dart';
import 'package:new_wallpaper/Provider/PhotoFavorite.dart';
import 'package:new_wallpaper/screens/DetailScreen.dart';
import 'package:new_wallpaper/screens/NotFound.dart';
import 'package:new_wallpaper/theme/style.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation:0,
        backgroundColor: Theme.of(context).cardColor,
      ),
      body: FutureBuilder(
          future: Provider.of<SLocalStorage>(context, listen: false)
              .fetchLoveList(),
          builder: (ctx, snap) => snap.connectionState ==
                  ConnectionState.waiting
              ? CircularProgressIndicator()
              : Consumer<SLocalStorage>(
                  builder: (ctx, love, _) => love.courseList.isEmpty
                      ? NotFoundScreen()
                      : new StaggeredGridView.countBuilder(
                          itemCount: love.courseList.length,
                          staggeredTileBuilder: (i) =>
                              StaggeredTile.count(2, i.isEven ? 3.5 : 2.8),
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                          crossAxisCount: 4,
                          itemBuilder: (BuildContext context, i) => Stack(
                            alignment: Alignment.topRight,
                            fit: StackFit.expand,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => DetailScreen(
                                          image: love.courseList[i])));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          width: 10, color: AppTheme.black4)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.network(
                                      love.courseList[i],
                                      fit: BoxFit.cover,
                                      // repeat: ImageRepeat.noRepeat,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(

                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(60)),
                                  child: GestureDetector(
                                      onTap: () {
                                        if (love.courseList
                                            .contains(love.courseList[i])) {
                                          love.removeCourse(
                                              url: love.courseList[i]);
                                        } else {
                                          love.addToLoveList(
                                              photo: love.courseList[i]);
                                        }
                                      },
                                      child: love.courseList.isEmpty
                                          ? Icon(
                                              Icons.favorite_border,
                                              color: AppTheme.black1,
                                              size: 30,
                                            )
                                          : love.courseList
                                                  .contains(love.courseList[i])
                                              ? Icon(
                                                  Icons.favorite,
                                                  color: AppTheme.green,
                                                  size: 30,
                                                )
                                              : Icon(
                                                  Icons.favorite_border,
                                                  color: AppTheme.black1,
                                                  size: 30,
                                                )),
                                ),
                              )
                            ],
                          ),
                        ))),
    );
  }
}
