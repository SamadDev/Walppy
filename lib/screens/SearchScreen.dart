import 'package:flutter/material.dart';
import 'package:new_wallpaper/localization/language.dart';
import 'package:new_wallpaper/module/Pixel.dart';
import 'package:new_wallpaper/screens/DetailScreen.dart';
import 'package:new_wallpaper/theme/style.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final text = TextEditingController();

  Widget build(BuildContext context) {
    final isLoading = Provider.of<Pixel>(context);
    int _index = 2;
    final data = Provider.of<Pixel>(context, listen: false);
    final language = Provider.of<Language>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 50,
                  child: TextField(
                    controller: text,
                    textCapitalization: TextCapitalization.characters,
                    style: Theme.of(context).textTheme.bodyText1,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(top: 17, right: 10, left: 10),
                      border: InputBorder.none,
                      suffixIcon: TextButton(
                        onPressed: () async {
                          await Provider.of<Pixel>(context, listen: false)
                              .search(
                            _index,
                            remove: false,
                            category: text.text,
                          );
                        },
                        child: Icon(
                          Icons.search,
                          color: Theme.of(context).buttonColor,
                          size: 30,
                        ),
                      ),
                        hintStyle: Theme.of(context).textTheme.headline4,
                      hintText: language.words['search to'],
                    ),
                  ),
                ),
              ),
              if (text.text.isNotEmpty)
                isLoading.isSearch
                    ? Positioned(
                        bottom: 10,
                        child: Center(child: CircularProgressIndicator()))
                    : Container(
                        height: 1000,
                        child: Consumer<Pixel>(
                          builder: (ctx, photo, _) => LazyLoadScrollView(
                            onEndOfPage: () {
                              Fluttertoast.showToast(
                                  msg: language.words['message'],
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: AppTheme.green,
                                  textColor: AppTheme.white,
                                  fontSize: 16.0);
                              _index = _index + 1;
                              data.search(
                                _index,
                                remove: true,
                                category: text.text,
                              );
                            },
                            child: StaggeredGridView.countBuilder(
                              itemCount: photo.searchModule!.photos!.length,
                              staggeredTileBuilder: (i) => StaggeredTile.count(
                                  (i % 7 == 0) ? 3 : 1, (i % 7 == 0) ? 2 : 1),
                              mainAxisSpacing: 2.0,
                              crossAxisSpacing: 2.0,
                              crossAxisCount: 4,
                              itemBuilder: (BuildContext context, i) =>
                                  GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) => DetailScreen(
                                        image: photo.searchModule!.photos![i]
                                            .src!.landscape
                                            .toString(),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          width: 5, color: AppTheme.black4)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: CachedNetworkImage(
                                      imageUrl: photo
                                          .searchModule!.photos![i].src!.large
                                          .toString(),
                                      fit: BoxFit.cover,
                                      placeholder: (ctx, snap) => Opacity(
                                          opacity: 0.1,
                                          child: Image.asset(
                                              'assets/images/walpy.jpg',
                                              fit: BoxFit.cover)),
                                      // repeat: ImageRepeat.noRepeat,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
            ],
          ),
        ),
      ),
    );
  }
}
