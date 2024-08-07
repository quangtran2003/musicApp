import 'package:do_an/net_working/models/track.dart';
import 'package:do_an/net_working/responstory/all_responstory.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  var historyPlay = Rxn<List<String>?>();
  var favourite = Rxn<List<String>?>();
  var playlist = Rxn<List<String>?>();
  final _listTrackRespon = Responstory();
  final RxList<TrackModel> historyTracks = RxList.empty();
  final RxList<TrackModel> favouriteTracks = RxList.empty();
  final RxList<TrackModel> playlistTracks = RxList.empty();
  final userName = RxnString();
  var isDarkMode = false.obs;
  var loadingHistory = true.obs;

  onInit() {
    super.onInit();
    loadHistoryPlay();
    loadPlaylist();
    loadfavourite();
    getNameUser();
    getDarkMode();
  }

  Future<void> getDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkMode.value = prefs.getBool('isDarkMode') ?? false;
  }

  Future changeDarkMode() async {
    isDarkMode.value = !isDarkMode.value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode.value);
    Get.changeTheme(
        isDarkMode.value == false ? ThemeData.light() : ThemeData.dark());
  }

  void getNameUser() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        for (final providerProfile in user.providerData) {
          userName.value = providerProfile.email;
        }
      }
    });
  }

  Future<void> loadHistoryPlay() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? history = prefs.getStringList('playHistory');
    historyPlay(history ?? []);
    getSongHistory();
  }

  Future<void> loadfavourite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favour = prefs.getStringList('favourite');
    favourite(favour ?? []);
    getSongFavourite();
  }

  Future<void> loadPlaylist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? playl = prefs.getStringList('playlist');
    playlist(playl ?? []);
    getSongPlaylist();
  }

  Future<void> getSongHistory() async {
    List<TrackModel?> results = await Future.wait(
      List.generate(
          historyPlay.value?.length ?? 0,
          (index) => _listTrackRespon
              .getTrack(historyPlay.value?[index].toString() ?? '')),
    );
    List<TrackModel> filteredResults =
        results.where((item) => item != null).cast<TrackModel>().toList();

    historyTracks.value = filteredResults;
    loadingHistory.value = false;
  }

  Future<void> getSongFavourite() async {
    List<TrackModel?> results = await Future.wait(
      List.generate(
          favourite.value?.length ?? 0,
          (index) => _listTrackRespon
              .getTrack(favourite.value?[index].toString() ?? '')),
    );
    List<TrackModel> filteredResults =
        results.where((item) => item != null).cast<TrackModel>().toList();

    favouriteTracks.value = filteredResults;
  }

  Future<void> getSongPlaylist() async {
    List<TrackModel?> results = await Future.wait(
      List.generate(
          playlist.value?.length ?? 0,
          (index) => _listTrackRespon
              .getTrack(playlist.value?[index].toString() ?? '')),
    );
    List<TrackModel> filteredResults =
        results.where((item) => item != null).cast<TrackModel>().toList();

    playlistTracks.value = filteredResults;
  }

  Future<void> deletefavourite(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favour = prefs.getStringList('favourite');
    favour ??= [];
    favour.removeAt(index);
    prefs.setStringList('favourite', favour);
    favourite(favour);
    favouriteTracks.removeAt(index);
  }

  Future<void> deletePlaylist(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? playl = prefs.getStringList('playlist');
    playl ??= [];
    playl.removeAt(index);
    prefs.setStringList('playlist', playl);
    playlist(playl);
    playlistTracks.removeAt(index);
  }
}
