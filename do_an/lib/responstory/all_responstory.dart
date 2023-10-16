// ignore_for_file: empty_catches, unused_local_variable

import 'package:dio/dio.dart';
import 'package:do_an/net_working/models/album.dart';
import 'package:do_an/net_working/models/artist.dart';
import 'package:do_an/net_working/models/search.dart';
import 'package:do_an/net_working/models/track.dart';
import 'package:do_an/responstory/http_sevice.dart';
import 'package:do_an/responstory/url.dart';
import '../net_working/chart.dart';
import '../net_working/models/tracklist_artist.dart';
import '../net_working/models/tracklist_playlist.dart';

class TrackResponstory {
  String id;
  TrackResponstory({
    required this.id,
  });

  final HttpService _service = HttpService();
  Future<TrackModel?> getTrack() async {
    try {
      final Response? response = await _service.request(Url.getTrack + id);

      return TrackModel.fromJson("dataResponse" as Map<String, dynamic>);
    } catch (e) {}
    return null;
  }
}

class AlbumResponstory {
  String id;
  AlbumResponstory({
    required this.id,
  });

  final HttpService _service = HttpService();
  Future<AlbumModel?> getAlbum() async {
    try {
      final Response? response = await _service.request(Url.getAlbum + id);
      return AlbumModel.fromJson("dataResponse" as Map<String, dynamic>);
    } catch (e) {}
    return null;
  }
}

class ArtistResponstory {
  String id;
  ArtistResponstory({
    required this.id,
  });

  final HttpService _service = HttpService();
  Future<ArtistModel?> getArtist() async {
    try {
      final Response? response = await _service.request(Url.getArtist + id);
      return ArtistModel.fromJson("dataResponse" as Map<String, dynamic>);
    } catch (e) {}
    return null;
  }
}

class SearchResponstory {
  String query;
  SearchResponstory({
    required this.query,
  });

  final HttpServiceSearch _service = HttpServiceSearch();
  Future<SearchModel?> getSearch() async {
    try {
      //  final Url url = Url(); // Tạo URL trong phương thức khởi tạo
      final Response? response =
          await _service.request(url: Url.getSearch, query: query);
      return SearchModel.fromJson("dataResponse" as Map<String, dynamic>);
    } catch (e) {}
    return null;
  }
}

class TrackListPlaylistResponstory {
  String id;
  TrackListPlaylistResponstory({
    required this.id,
  });

  final HttpService _service = HttpService();
  Future<TracklistPlaylistModel?> getTracklistPlaylist() async {
    try {
      final Url url = Url(playlistId: id); // Tạo URL trong phương thức khởi tạo
      final Response? response =
          await _service.request(url.getTrackListPlaylist);
      print(response?.data);
      return TracklistPlaylistModel.fromJson(
          "dataResponse" as Map<String, dynamic>);
    } catch (e) {
      print('testplist');
    }
    return null;
  }
}

class TrackListArtistResponstory {
  String id;
  TrackListArtistResponstory({
    required this.id,
  });
  final HttpService _service = HttpService();
  Future<TracklistArtistModel?> getTracklistArtist() async {
    try {
      final Url url = Url(artistId: id); // Tạo URL trong phương thức khởi tạo
      final Response? response = await _service.request(url.getTrackListArtist);
      print(response?.data);
      return TracklistArtistModel.fromJson(
          "dataResponse" as Map<String, dynamic>);
    } catch (e) {}
    return null;
  }
}

class ChartResponstory {
  final HttpService _service = HttpService();
  Future<ChartModel?> getChart() async {
    try {
      final Response? response = await _service.request(Url.getChart);
      return ChartModel.fromJson("dataResponse" as Map<String, dynamic>);
    } catch (e) {
      print('gg');
    }
    return null;
  }
}
