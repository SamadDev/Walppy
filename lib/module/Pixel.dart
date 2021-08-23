import 'dart:convert';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

class PixelModel with ChangeNotifier {
  List<Photos>? photos;
  String moreImage = '';
  int? total;

  PixelModel({this.photos, this.total});

  PixelModel.fromJson(json) {
    total = json['total_results'];
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos!.add(Photos.fromJson(v));
      });
    }
  }
}

class Photos {
  String? avgColor;
  Src? src;

  Photos({
    this.avgColor,
    this.src,
  });

  Photos.fromJson(json) {
    avgColor = json['avg_color'];
    src = Src.fromJson(json['src']);
  }
}

class Src {
  String? original;
  String? large2x;
  String? large;
  String? medium;
  String? small;
  String? portrait;
  String? landscape;
  String? tiny;

  Src(
      {this.original,
      this.large2x,
      this.large,
      this.medium,
      this.small,
      this.portrait,
      this.landscape,
      this.tiny});

  Src.fromJson(json) {
    original = json['original'];
    large2x = json['large2x'];
    large = json['large'];
    medium = json['medium'];
    small = json['small'];
    portrait = json['portrait'];
    landscape = json['landscape'];
    tiny = json['tiny'];
  }
}

class Pixel with ChangeNotifier {
  PixelModel? module;

  Future<void> getPhotos(category, page, {bool remove = true}) async {
    try {
      final response = await http.get(
          Uri.parse(
              "https://api.pexels.com/v1/search?query=$category&per_page=30&page=$page"),
          headers: {
            'Authorization':
                'Bearer 563492ad6f917000010000018fe27b2e7b9749c7ab67dc5da14cf231'
          });

      var jsonData = json.decode(response.body);

      if (module == null) {
        module = PixelModel.fromJson(jsonData);
        notifyListeners();
      } else {
        if (remove == false) {
          module!.photos!.clear();
        }
        PixelModel model2 = PixelModel.fromJson(jsonData);
        module!.photos!.addAll(model2.photos!.toList());
        notifyListeners();
      }
    } catch (error) {
      print(error);
    }
  }

  PixelModel? searchModule;

  Future<void> search( page, {bool remove = true,String category='all'}) async {

    try {
      if(searchModule==null){
        print(isSearch);
        changeState();
      }
      final response = await http.get(
          Uri.parse(
              "https://api.pexels.com/v1/search?query=$category&per_page=30&page=$page"),
          headers: {
            'Authorization':
                'Bearer 563492ad6f917000010000018fe27b2e7b9749c7ab67dc5da14cf231'
          });
      var jsonData = json.decode(response.body);

      if (searchModule == null) {
        searchModule = PixelModel.fromJson(jsonData);
        changeState();
        notifyListeners();
      } else {
        print('false');
        if (remove == false) {
          searchModule!.photos!.clear();
        }
        print('else');
        PixelModel model2 = PixelModel.fromJson(jsonData);
        searchModule!.photos!.addAll(model2.photos!.toList());
        print(searchModule!.photos!.length);
        notifyListeners();
      }
    } catch (error) {
      print(error);
    }
  }
  bool isSearch=false;
  void changeState(){
    isSearch = !isSearch;
    notifyListeners();
  }
}
