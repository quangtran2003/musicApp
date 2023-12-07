// ignore_for_file: invalid_use_of_protected_member

import 'package:clipboard/clipboard.dart';
import 'package:do_an/net_working/models/track.dart';
import 'package:do_an/refactoring/text.dart';
import 'package:do_an/responstory/all_responstory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:rxdart/rxdart.dart' as ok;
import 'package:shared_preferences/shared_preferences.dart';

class PlayMusicController extends GetxController {
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
  var isSongBottom = RxnBool();
  Stream<DurationState>? durationState;
  List<String> listSong = [];
  List<AudioSource> listAudio = [];

  void initProgessBar() {
    durationState =
        ok.Rx.combineLatest2<Duration, PlaybackEvent, DurationState>(
            audioPlayer.positionStream,
            audioPlayer.playbackEventStream,
            (position, playbackEvent) => DurationState(
                  progress: position,
                  buffered: playbackEvent.bufferedPosition,
                  total: playbackEvent.duration,
                ));
  }

  void getListTrack(List<TrackModel> value) {
    final List<TrackModel> tracks = [];
    tracks.addAll(value);
    trackList.value = tracks;
  }

  Future initData(int? songId, List<TrackModel> listTrack,
      List<int?> listIdSong, bool? isSong) async {
    isSongBottom.value = isSong;
    if (isSongBottom.value == null) {
      getListTrack(listTrack);
      getTrack(songId ?? 0);
      checkConpletion();
      getIndexSong(songId, listIdSong);
      initProgessBar();
      // getPlaylist();
      loopListTrack.value = false;
      loopSong.value = false;
    }
  }

  Future<void> updateData(TrackModel data) async {
    // audioPlayer.stop();
    //audioPlayer.dispose();
    trackData.value = data;
    initProgessBar();
    playMusic();

    isPlaying.value = true;
  }

  Future<void> playMusic() async {
    //audioPlayer.stop();
    audioPlayer.setAudioSource(AudioSource.uri(
      Uri.parse(trackData.value?.preview ?? ''),
      tag: MediaItem(
        id: '1',
        album: trackData.value?.artist?.name,
        title: trackData.value?.title ?? '',
        artUri: Uri.parse(trackData.value?.album?.coverMedium ?? ''),
      ),
    ));
    audioPlayer.play();
  }

  Future<void> getTrack(int id) async {
    final value = await _respon.getTrack(id.toString());
    trackData.value = value;
    playMusic();

    isPlaying.value = true;
  }

  @override
  void dispose() {
    Get.delete<PlayMusicController>();
    super.dispose();
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
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
    int seconds = value % 60;
    int minutes = value ~/ 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  void checkFavorite() {
    isFavorite.value = !isFavorite.value;
  }

  Future Function(Duration? position, {int? index}) seekk() {
    return audioPlayer.seek;
  }

  void checkPlaying() {
    if (trackData.value == null) {
      return;
    }
    if (isPlaying.value) {
      audioPlayer.pause();
    } else {
      audioPlayer.play();
    }
    isPlaying.value = !isPlaying.value;
  }

  void checkIndexPage(int index) {
    indexPage.value = index;
  }

  Future<void> checkConpletion() async {
    audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        audioPlayer.stop();
        isPlaying.value = false;
      } else {}
    });
  }

  void onLoopListTrack() {
    if (!isPlaying.value) {
      audioPlayer.stop();
    }
    loopListTrack.value = !loopListTrack.value;
    audioPlayer.playerStateStream.listen((state) {
      if (loopListTrack.value) {
        if (state.processingState == ProcessingState.completed) {
          if (indexSong.value != null) {
            indexSong.value = indexSong.value! + 1;
            if (indexSong.value! >= trackList.value.length) {
              indexSong.value = 0;
            }
            updateData(trackList[indexSong.value!]);
          }
        }
      } else {
        checkConpletion();
      }
    });
  }

  Future onLoopSong() async {
    if (!isPlaying.value) {
      audioPlayer.stop();
    }
    loopSong.value = !loopSong.value;

    audioPlayer.playerStateStream.listen((state) {
      if (loopSong.value) {
        audioPlayer.setLoopMode(LoopMode.one);
      } else {
        audioPlayer.setLoopMode(LoopMode.off);
        checkConpletion();
      }
    });
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
        builder: (builderContext) {
          return SizedBox(
              height: x,
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
              ));
        });

    await FlutterClipboard.copy(link);
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });
  }

  void saveLink(String link) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('temporaryLink', link);
  }

  var score = 0.obs;
  void load() async {
    final scoreData = await SharedPreferences.getInstance();
    score.value = scoreData.getInt('score') ?? 0;
  }

  void count() async {
    final scoreData = await SharedPreferences.getInstance();
    score.value = scoreData.getInt('score') ?? 0 + 1;
    scoreData.setInt('score', score.value);
  }
}

class DurationState {
  const DurationState({
    required this.progress,
    required this.buffered,
    this.total,
  });
  final Duration progress;
  final Duration buffered;
  final Duration? total;
}
