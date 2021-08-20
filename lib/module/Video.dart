import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

// class VideoModule{
//   var page;
//   var duration;
//   String ?videoFile;
//  String ?image;
//
//   VideoModule(
//       {
//         required this.page,
//       required this.image,
//       required this.duration,
//       required this.videoFile});
//
//   VideoModule.fromJson(Map <String, dynamic> json) {
//     page=json['page'];
//     duration=json['videos'][0]['duration'];
//     videoFile=json['videos'][0]['video_files'][2]['link'];
//     image=json['videos'][0]['video_pictures'][6]['picture'];
//   }
// }

class Video with ChangeNotifier {
  VideosModule? videoModule;

  Future<void> getVideo(category, page, {bool remove = true}) async {
    try {
      print("page$page");
      final response = await http.get(
          Uri.parse(
              "https://api.pexels.com/videos/search?query='nature'&per_page=35&page=$page"),
          headers: {
            'Authorization':
                'Bearer 563492ad6f917000010000018fe27b2e7b9749c7ab67dc5da14cf231'
          });
      var jsonData = json.decode(response.body);

      if (videoModule == null) {
        videoModule = VideosModule.fromJson(jsonData);
        notifyListeners();
      } else {
        if (remove == false) {
          videoModule!.videos!.clear();
        }
        VideosModule model2 = VideosModule.fromJson(jsonData);
        videoModule!.videos!.addAll(model2.videos!.toList());
        notifyListeners();
      }
    } catch (error) {
      print(error);
    }
  }
}


class VideosModule {
  List<Videos>? videos;

  VideosModule({required this.videos});

  VideosModule.fromJson(Map<String, dynamic> json) {
    if (json['videos'] != null) {
      videos = <Videos>[];
      json['videos'].forEach((v) {
        videos!.add(new Videos.fromJson(v));
      });
    }
  }
}

class Videos {
  List<VideoFiles>? videoFiles;
  List<VideoPictures>? videoPictures;

  Videos({required this.videoFiles, required this.videoPictures});

  Videos.fromJson(Map<String, dynamic> json) {
    if (json['video_files'] != null) {
      videoFiles = <VideoFiles>[];
      json['video_files'].forEach((v) {
        videoFiles!.add(new VideoFiles.fromJson(v));
      });
    }
    if (json['video_pictures'] != null) {
      videoPictures = <VideoPictures>[];
      json['video_pictures'].forEach((v) {
        videoPictures!.add(new VideoPictures.fromJson(v));
      });
    }
  }
}

class VideoFiles {
  String? link;

  VideoFiles({required this.link});

  VideoFiles.fromJson(Map<String, dynamic> json) {
    link = json['link'];
  }
}

class VideoPictures {
  String? picture;

  VideoPictures({required this.picture});

  VideoPictures.fromJson(Map<String, dynamic> json) {
    picture = json['picture'];
  }
}
