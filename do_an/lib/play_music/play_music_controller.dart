import 'package:do_an/net_working/models/track.dart';
import 'package:do_an/responstory/all_responstory.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';

class PlayMusicController extends GetxController {
  AudioPlayer audioPlayer = AudioPlayer();
  final _respon = Responstory();
  final trackData = Rxn<TrackModel>();

  var durationString = RxnString();
  var positionString = ''.obs;
  var durationInt = 0.obs;
  var positionInt = 0.obs;
  var isPlaying = false.obs;
  Future<void> getTrack(int id) async {
    final value = await _respon.getTrack(id.toString());
    trackData.value = value;
  }

  String format(int value) {
    int seconds = value ~/ 60;
    int minutes = value - seconds;
    return '${seconds}:${minutes.toString().padLeft(2, '0')}';
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

  void increaseVolume() {
    audioPlayer.setVolume(1.0); // Giá trị từ 0.0 đến 1.0
  }

  void decreaseVolume() {
    audioPlayer.setVolume(0.5); // Giá trị từ 0.0 đến 1.0
  }

  void loadMusic(String musicUrl) async {
    await audioPlayer.play(UrlSource(musicUrl));
  }

  void seek(double value) {
    audioPlayer.seek(Duration(milliseconds: value.toInt()));
  }

  void checkPlaying() {
    if (isPlaying.value) {
      audioPlayer.pause();
    } else {
      audioPlayer.resume();
    }
    isPlaying.value = !isPlaying.value;
  }
}
