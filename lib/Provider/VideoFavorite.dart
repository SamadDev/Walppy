import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SLocalStorage with ChangeNotifier {
  List<String> videoFavorite = [];

  Future<void> fetchVideoFavorite() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      videoFavorite = preferences.getStringList('url') ?? [];
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  addVideoFavorite({video}) async {
    try {
      videoFavorite.add(video);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setStringList('url', videoFavorite);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  removeVideoFavorite({url}) async {
    try {
      videoFavorite.removeAt(videoFavorite.indexOf(url));
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.remove('url');
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
