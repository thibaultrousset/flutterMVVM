import 'package:exemple_mvvm/model/apis/api_response.dart';
import 'package:exemple_mvvm/model/media.dart';
import 'package:exemple_mvvm/model/media_repository.dart';
import 'package:flutter/cupertino.dart';

class MediaViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.error('Error initail data');

  Media? _media;
  List<Media>? mediaList;

  ApiResponse get response {
    return _apiResponse;
  }

  Media? get media {
    return _media;
  }

  /// Call the media service and gets the data of requested media data of
  /// an artist.
  Future<void> fetchMediaData(String value) async {
    _apiResponse = ApiResponse.loading('Fetching artist data');
    notifyListeners();
    try {
      mediaList = null;
      mediaList = await MediaRepository().fetchMediaList(value);
      _apiResponse = ApiResponse.completed(mediaList);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
      print(e);
    }
    notifyListeners();
  }

  void setSelectedMedia(Media? media) {
    _media = media;
    notifyListeners();
  }

  // void selectedNextPreviousMedia(Media? media, int index) {
  //   _media = media;
  //   notifyListeners();
  // }
}
