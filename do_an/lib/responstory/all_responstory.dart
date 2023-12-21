// ignore_for_file: empty_catches, unused_local_variable

import 'package:dio/dio.dart';
import 'package:do_an/net_working/models/album.dart';
import 'package:do_an/net_working/models/artist.dart';
import 'package:do_an/net_working/models/playlist.dart';
import 'package:do_an/net_working/models/search.dart';
import 'package:do_an/net_working/models/track.dart';
import 'package:do_an/responstory/http_sevice.dart';
import 'package:do_an/responstory/url.dart';

import '../net_working/models/chart.dart';
import '../net_working/models/tracklist_artist.dart';

class Responstory {
  final HttpService _service = HttpService();

  Future<TrackModel?> getTrack(String id) async {
    try {
      final Response? response = await _service.request(Url.getTrack + id);
      final responseData = response?.data;
      return responseData != null ? TrackModel.fromJson(response?.data) : null;
    } catch (e) {}
    return null;
  }

  Future<AlbumModel?> getAlbum(String id) async {
    try {
      final Response? response = await _service.request(Url.getAlbum + id);
      final responseData = response?.data;
      return responseData != null ? AlbumModel.fromJson(response?.data) : null;
    } catch (e) {}
    return null;
  }

  Future<ArtistModel?> getArtist(String id) async {
    try {
      final Response? response = await _service.request(Url.getArtist + id);
      final responseData = response?.data;
      return responseData != null ? ArtistModel.fromJson(response?.data) : null;
    } catch (e) {}
    return null;
  }

  Future<PlaylistModel?> getPlaylist(String id) async {
    try {
      final Response? response = await _service.request(Url.getPlaylist + id);
      final responseData = response?.data;
      return responseData != null
          ? PlaylistModel.fromJson(response?.data)
          : null;
    } catch (e) {}
    return null;
  }

  Future<TracklistArtistModel?> getTracklistArtist(String id) async {
    try {
      final Url url = Url(artistId: id);
      final Response? response = await _service.request(url.getTrackListArtist);
      final responseData = response?.data;
      return responseData != null
          ? TracklistArtistModel.fromJson(responseData)
          : null;
    } catch (e) {}
    return null;
  }

  Future<ChartModel?> getChart() async {
    try {
      final Response? response = await _service.request(Url.getChart);
      final responseData = response?.data;
      return responseData != null ? ChartModel.fromJson(responseData) : null;
    } catch (e) {}
    return null;
  }
}

class SearchResponstory {
  final HttpServiceSearch _service = HttpServiceSearch();
  Future<SearchModel?> getSearch(String query) async {
    try {
      final Response? response =
          await _service.request(url: Url.getSearch, query: query);
      final responseData = response?.data;
      return responseData != null ? SearchModel.fromJson(responseData) : null;
    } catch (e) {}
    return null;
  }
}
