// ignore_for_file: invalid_use_of_protected_member

import 'package:audioplayers/audioplayers.dart';
import 'package:clipboard/clipboard.dart';
import 'package:do_an/module/user/user_controller.dart';
import 'package:do_an/net_working/models/track.dart';
import 'package:do_an/refactoring/text.dart';
import 'package:do_an/responstory/all_responstory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayMusicController extends GetxController {
  final _controllerUser = Get.put(UserController());

  PlayerState playerState = PlayerState.stopped;
  AudioPlayer audioPlayer = AudioPlayer();
  RxList<TrackModel> trackList = RxList.empty();
  var indexPage = 0.obs;
  var isPlaying = false.obs;
  final _respon = Responstory();
  var trackData = Rxn<TrackModel>();
  var durationString = RxnString();
  var positionString = ''.obs;
  var durationInt = 0.obs;
  var positionInt = 0.obs;
  var indexSong = Rxn<int>();
  RxInt selectedIndex = 0.obs;
  var loopSong = false.obs;
  var loopListTrack = false.obs;
  var countdownSeconds = 0.obs;
  var isCountingDown = false.obs;
  var isFavorite = false.obs;
  var isPlaylist = false.obs;
  var favourite = Rxn<List<String?>>();
  var playlist = Rxn<List<String?>>();
  var historyPlay = Rxn<List<String?>>();

  void getListTrack(List<TrackModel> value) {
    final List<TrackModel> tracks = [];
    tracks.addAll(value);
    trackList.value = tracks;
  }

  Future initData(int? songId, List<TrackModel> listTrack,
      List<int?> listIdSong, bool? isSongBottom) async {
    if (isSongBottom == null) {
      getTrack(songId ?? 0);
      getListTrack(listTrack);
      onDurationChanged();
      onPositionChanged();
      checkConpletion();
      getIndexSong(songId, listIdSong);
    }
  }

  Future<void> updateData(TrackModel data) async {
    trackData.value = data;
    await audioPlayer.stop();
    isPlaying.value = true;
    await audioPlayer.play(UrlSource(trackData.value?.preview ?? ''));
    savePlayHistory();
    loadPlaylist();
    loadfavourite();
    _controllerUser.loadHistoryPlay();
  }

  Future<void> getTrack(int id) async {
    final value = await _respon.getTrack(id.toString());
    trackData.value = value;
    isPlaying.value = true;
    await audioPlayer.play(UrlSource(trackData.value?.preview ?? ''));
    savePlayHistory();
    loadPlaylist();
    loadfavourite();
    _controllerUser.loadHistoryPlay();
  }

  Future<void> stopMusic() async {
    await audioPlayer.stop();
  }

  Future<void> pauserMusic() async {
    isPlaying.value = false;
    await audioPlayer.pause();
  }

  void getIndexSong(int? idSong, List<int?> listIdSong) {
    indexSong.value = listIdSong.indexOf(idSong);
  }

  String format(int value) {
    int seconds = value ~/ 60;
    int minutes = value - seconds;
    return '$seconds:${minutes.toString().padLeft(2, '0')}';
  }

  void onDurationChanged() {
    audioPlayer.onDurationChanged.listen((Duration d) {
      durationInt.value = d.inSeconds.toInt();
      durationString.value = format(durationInt.value);
    });
  }

  void onPositionChanged() {
    audioPlayer.onPositionChanged.listen((Duration p) {
      positionInt.value = p.inSeconds.toInt();
      positionString.value = format(positionInt.value);
    });
  }

  void checkFavorite() {
    isFavorite.value = !isFavorite.value;
  }

  void checkPlaylist() {
    isPlaylist.value = !isPlaylist.value;
  }

  void seek(double value) {
    audioPlayer.seek(Duration(milliseconds: value.toInt()));
  }

  Future<void> loadMusic(String musicUrl) async {
    await audioPlayer.play(UrlSource(musicUrl));
  }

  void checkPlaying() {
    if (trackData.value == null) {
      return;
    }
    if (isPlaying.value) {
      audioPlayer.pause();
    } else {
      audioPlayer.resume();
    }
    isPlaying.value = !isPlaying.value;
  }

  void checkIndexPage(int index) {
    indexPage.value = index;
  }

  Future<void> checkConpletion() async {
    audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.completed) {
        stopMusic();
        isPlaying.value = false;
        // print("Song has end");
      }
    });
  }

  Future<void> onLoopListTrack() async {
    loopListTrack.value = !loopListTrack.value;
    audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (loopListTrack.value) {
        if (state == PlayerState.completed) {
          if (indexSong.value != null) {
            indexSong.value = indexSong.value! + 1;
            if (indexSong.value! >= trackList.value.length) {
              indexSong.value = 0;
            }
            updateData(trackList[indexSong.value!]);
          }
        }
      } else {
        if (state == PlayerState.completed) {
          isPlaying.value = false;
          audioPlayer.pause();
        }
      }
    });
  }

  Future<void> onLoopSong() async {
    loopSong.value = !loopSong.value;
    // isPlaying.value = true;
    audioPlayer.setReleaseMode(ReleaseMode.stop);

    if (loopSong.value == true) {
      audioPlayer.setReleaseMode(ReleaseMode.loop);
    } else {
      audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
        if (state == PlayerState.completed) {
          isPlaying.value = false;
          audioPlayer.pause();
          //  }
        }
      });
    }
  }

  void nextSong() {
    if (trackData.value == null) {
      return;
    }
    isPlaying.value = true;
    if (indexSong.value != null) {
      if (trackList.value.length == 1) {
        updateData(trackList[indexSong.value ?? 0]);
        return;
      }
      if (indexSong.value == trackList.value.length - 1) {
        indexSong.value = 0;
      }
      indexSong.value = indexSong.value! + 1;
      updateData(trackList[indexSong.value!]);
      //Get.changeTheme(theme)
    }
  }

  void backSong() {
    if (trackData.value == null) {
      return;
    }
    isPlaying.value = true;
    if (indexSong.value != null) {
      if (trackList.value.length == 1) {
        updateData(trackList[indexSong.value ?? 0]);
        return;
      }
      if (indexSong.value == 0) {
        indexSong.value = trackList.value.length - 1;
      }
      indexSong.value = indexSong.value! - 1;
      updateData(trackList[indexSong.value!]);
    }
  }

  void getLinkSong(BuildContext context, String link, double x) async {
    saveLink(link);

    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (builder) {
          return SizedBox(
            height: x / 4,
            child: Center(
              child: Container(
                height: 70,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: Center(
                  child: MyText(
                    text: "The song link has been copied!",
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          );
        });
    await Future.delayed(const Duration(seconds: 2));
    Get.back();
    // Sao chép đường link vào clipboard
    await FlutterClipboard.copy(link);
  }

  void saveLink(String link) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('temporaryLink', link);
  }

  Future<void> loadfavourite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favour = prefs.getStringList('favourite');
    favourite(favour ?? []);
    if (favourite.value!.contains(trackData.value?.id.toString())) {
      isFavorite.value = true;
    } else {
      isFavorite.value = false;
    }
  }

  Future<void> saveFavourite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? listFavourite = prefs.getStringList('favourite');

    listFavourite ??= [];
    if (isFavorite.value == true) {
      if (listFavourite.contains(trackData.value?.id.toString())) {
        return;
      } else {
        listFavourite.add(trackData.value?.id.toString() ?? ' id null');
      }
    } else {
      if (listFavourite.contains(trackData.value?.id.toString())) {
        listFavourite.remove(trackData.value?.id.toString());
      }
    }

    prefs.setStringList('favourite', listFavourite);
    _controllerUser.loadfavourite();
    favourite(listFavourite);
  }

  Future<void> loadPlaylist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? playlis = prefs.getStringList('playlist');
    playlist(playlis ?? []);
    if (playlist.value!.contains(trackData.value?.id.toString())) {
      isPlaylist.value = true;
    } else {
      isPlaylist.value = false;
    }
  }

  Future<void> savePlaylist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? listPlaylist = prefs.getStringList('playlist');

    listPlaylist ??= [];
    if (isPlaylist.value == true) {
      if (listPlaylist.contains(trackData.value?.id.toString())) {
        return;
      } else {
        listPlaylist.add(trackData.value?.id.toString() ?? ' id null');
      }
    } else {
      if (listPlaylist.contains(trackData.value?.id.toString())) {
        listPlaylist.remove(trackData.value?.id.toString());
      }
    }

    prefs.setStringList('playlist', listPlaylist);

    playlist(listPlaylist);
  }

  Future<void> loadHistoryPlay() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? history = prefs.getStringList('playHistory');
    historyPlay(history ?? []);
  }

  Future<void> savePlayHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? history = prefs.getStringList('playHistory');

    history ??= [];
    if (history.length >= 15) {
      history.removeLast();
    }

    if (trackData.value?.id != null) {
      if (history.contains(trackData.value?.id.toString())) {
        history.remove(trackData.value?.id.toString());
      }
      history.insert(0, trackData.value!.id.toString());
    }
    prefs.setStringList('playHistory', history);

    historyPlay(history);
  }
}
