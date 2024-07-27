import 'dart:async';

import 'package:audio_session/audio_session.dart';
import 'package:clipboard/clipboard.dart';
import 'package:do_an/components/text.dart';
import 'package:do_an/language/language_constant.dart';
import 'package:do_an/module/play_music/model_song_transfer.dart';
import 'package:do_an/module/user/user_controller.dart';
import 'package:do_an/net_working/models/track.dart';
import 'package:do_an/net_working/responstory/all_responstory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:rxdart/rxdart.dart' as rx;
import 'package:shared_preferences/shared_preferences.dart';

enum statusMusic { Playing, Pause, Completed, Loading, Idle, Buffering, Ready }

class PlayMusicController extends GetxController {
  final _controllerUser = Get.put(UserController());

  late AudioPlayer audioPlayer;
  RxList<TrackModel> trackList = RxList.empty();
  final isLoading = true.obs;
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
  var isLoopSong = false.obs;
  var isRandomSong = false.obs;
  var countdownSeconds = 0.obs;
  var isCountingDown = false.obs;
  var isFavorite = false.obs;
  var isPlaylist = false.obs;
  var favourite = Rxn<List<String?>>();
  var playlist = Rxn<List<String?>>();
  var historyPlay = Rxn<List<String?>>();
  var status = statusMusic.Pause.obs;
  var isPlayAnimation = false.obs;
  ModelSongTransfer? dataTransfer = Get.arguments;
  ConcatenatingAudioSource? playlistMusic;
  PlayerState playerState = PlayerState(false, ProcessingState.loading);
  @override
  void onInit() {
    audioPlayer = AudioPlayer();
    audioPlayer.playerStateStream.listen((state) {
      if (state.playing) {
        isPlaying.value = true;
        print('\n\n\n fsdfsdfsdfosdfsdfsdfsdbject');
      } else
        switch (state.processingState) {
          case ProcessingState.idle:
            status.value = statusMusic.Idle;
          case ProcessingState.loading:
            status.value = statusMusic.Loading;
          case ProcessingState.buffering:
            status.value = statusMusic.Buffering;
          case ProcessingState.ready:
            status.value = statusMusic.Ready;
          case ProcessingState.completed:
            status.value = statusMusic.Completed;
        }
    });
    super.onInit();
  }

  void getListTrack(List<TrackModel> value) {
    final List<TrackModel> tracks = [];
    tracks.addAll(value);
    trackList.value = tracks;
  }

  // listenStatus() {
  //   audioPlayer.playerStateStream.listen((state) {
  //     if (state.playing)
  //       isPlaying.value = true;
  //     else
  //       switch (state.processingState) {
  //         case ProcessingState.idle:
  //           status.value = statusMusic.Idle;
  //         case ProcessingState.loading:
  //           status.value = statusMusic.Loading;
  //         case ProcessingState.buffering:
  //           status.value = statusMusic.Loading;
  //         case ProcessingState.ready:
  //           status.value = statusMusic.Ready;
  //         case ProcessingState.completed:
  //           status.value = statusMusic.Completed;
  //       }
  //   });
  // }

  Future initData(ModelSongTransfer? dataTransfer) async {
    if (dataTransfer?.isSongBottom == false) {
      //getPlaylistSuggets();
      await getTrack(dataTransfer?.songId ?? 0);
      //listenStatus();
     // getListTrack(dataTransfer?.listTrack ?? []);
     // getIndexSong(dataTransfer?.songId, dataTransfer?.listIdSong ?? []);
    }
  }

  void getPlaylistSuggets() {
    final dataTransfer = Get.arguments as ModelSongTransfer?;
    playlistMusic = ConcatenatingAudioSource(
        useLazyPreparation: true,
        shuffleOrder: DefaultShuffleOrder(),
        children: dataTransfer?.listTrack != null
            ? dataTransfer!.listTrack!.map((item) {
                return AudioSource.uri(
                  Uri.parse(item.preview ?? ''),
                  tag: MediaItem(
                    // Specify a unique ID for each media item:
                    id: dataTransfer.listTrack!.indexOf(item).toString(),
                    // Metadata to display in the notification:
                    album: item.album?.title,
                    title: item.title ?? 'Not name',
                    artUri: Uri.parse(item.album?.coverSmall ?? ''),
                  ),
                );
              }).toList()
            : []);
  }

  // Future<void> updateData(TrackModel data) async {
  //   trackData.value = data;
  //   await playMusic();
  //   savePlayHistory();
  //   loadPlaylist();
  //   loadfavourite();
  //   //checkStatusMusic();
  //   _controllerUser.loadHistoryPlay();
  // }

  Future<void> playMusic() async {
    int _nextMediaId = 0;
    final _playlist = ConcatenatingAudioSource(children: [
      ClippingAudioSource(
        start: const Duration(seconds: 60),
        end: const Duration(seconds: 90),
        child: AudioSource.uri(Uri.parse(
            "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3")),
        tag: MediaItem(
          id: '${_nextMediaId++}',
          album: "Science Friday",
          title: "A Salute To Head-Scratching Science (30 seconds)",
          artUri: Uri.parse(
              "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg"),
        ),
      ),
      AudioSource.uri(
        Uri.parse(
            "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3"),
        tag: MediaItem(
          id: '${_nextMediaId++}',
          album: "Science Friday",
          title: "A Salute To Head-Scratching Science",
          artUri: Uri.parse(
              "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg"),
        ),
      ),
      AudioSource.uri(
        Uri.parse(
            "https://s3.amazonaws.com/scifri-segments/scifri201711241.mp3"),
        tag: MediaItem(
          id: '${_nextMediaId++}',
          album: "Science Friday",
          title: "From Cat Rheology To Operatic Incompetence",
          artUri: Uri.parse(
              "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg"),
        ),
      ),
      AudioSource.uri(
        Uri.parse("asset:///audio/nature.mp3"),
        tag: MediaItem(
          id: '${_nextMediaId++}',
          album: "Public Domain",
          title: "Nature Sounds",
          artUri: Uri.parse(
              "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg"),
        ),
      ),
    ]);
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    audioPlayer.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    try {
      await audioPlayer.setAudioSource(_playlist);
    } catch (e, stackTrace) {
      // Catch load errors: 404, invalid url ...
      print("Error loading playlist: $e");
      print(stackTrace);
    }

// final duration = await audioPlayer.setUrl(// Load a URL
//         'https://file-examples.com/storage/fe3f15b9da66a36baa1b51a/2017/11/file_example_MP3_2MG.mp3'); // Schemes: (https: | file: | asset: )
//     audioPlayer.play(); // Play without waiting for completion
    //await audioPlayer.play();

    // if (playlistMusic != null && playlistMusic?.children != []) {
    //   await audioPlayer.setAudioSource(playlistMusic!,
    //       initialIndex: 0, initialPosition: Duration.zero);
    //   isPlaying.value = true;
    // } else {
    //   Get.snackbar('Thông báo', 'Dữ liệu lỗi!');
    //   isLoading.value = false;
    // }
  }

  // void checkStatusMusic() {
  //   audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
  //     if (state == PlayerState.playing) {
  //       isPlayAnimation.value = true;
  //     } else
  //       isPlayAnimation.value = false;
  //   });
  // }

  Future<void> getTrack(int id) async {
    final value = await _respon.getTrack(id.toString());
    trackData.value = value;
    isPlaying.value = true;
    await playMusic();
    savePlayHistory();
    loadPlaylist();
    loadfavourite();
    _controllerUser.loadHistoryPlay();
  }

  Future disPoseMusic() async {
    await audioPlayer.dispose();
  }

  Future<void> stopMusic() async {
    await audioPlayer.stop();
  }

  Future<void> pauserMusic() async {
    isPlaying.value = false;
    await audioPlayer.pause();
    status.value = statusMusic.Pause;
  }

  void getIndexSong(int? idSong, List<int?> listIdSong) {
    indexSong.value = listIdSong.indexOf(idSong);
  }

  String format(int value) {
    int seconds = value ~/ 60;
    int minutes = value - seconds;
    return '$seconds:${minutes.toString().padLeft(2, '0')}';
  }

  Stream<PositionData> get positionDataStream =>
      rx.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          audioPlayer.positionStream,
          audioPlayer.bufferedPositionStream,
          audioPlayer.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  void checkFavorite() {
    isFavorite.value = !isFavorite.value;
  }

  void checkPlaylist() {
    isPlaylist.value = !isPlaylist.value;
  }

  void seek(double value) {
    audioPlayer.seek(Duration(milliseconds: value.toInt()));
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

  // Future<void> checkConpletion() async {
  //   audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
  //     if (state == PlayerState.completed) {
  //       stopMusic();
  //       isPlaying.value = false;
  //     }
  //   });
  // }

  // Future<void> onLoopListTrack() async {
  //   loopListTrack.value = !loopListTrack.value;
  //   audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
  //     if (loopListTrack.value) {
  //       if (state == PlayerState.completed) {
  //         if (indexSong.value != null) {
  //           indexSong.value = indexSong.value! + 1;
  //           if (indexSong.value! >= trackList.length) {
  //             indexSong.value = 0;
  //           }
  //           updateData(trackList[indexSong.value!]);
  //         }
  //       }
  //     } else {
  //       if (state == PlayerState.completed) {
  //         isPlaying.value = false;
  //         audioPlayer.pause();
  //       }
  //     }
  //   });
  // }

  Future<void> onLoopSong() async {
    isLoopSong.value = !isLoopSong.value;
    if (isLoopSong.value) {
      await audioPlayer.setLoopMode(LoopMode.one);
      audioPlayer.play();
    } else {
      await audioPlayer.setLoopMode(LoopMode.off);
      audioPlayer.play();
    }
  }

  Future<void> onRandomSong() async {
    isRandomSong.value = !isRandomSong.value;
    if (isRandomSong.value) {
      await audioPlayer.setShuffleModeEnabled(true);
      audioPlayer.play();
    } else {
      await audioPlayer.setShuffleModeEnabled(false);
      audioPlayer.play();
      if (status.value == statusMusic.Completed) audioPlayer.pause();
    }
  }

  void nextSong() async {
    await audioPlayer.seekToNext();

    // if (trackData.value == null) {
    //   return;
    // }
    // isPlaying.value = true;
    // if (indexSong.value != null) {
    //   if (trackList.length == 1) {
    //     updateData(trackList[indexSong.value ?? 0]);
    //     return;
    //   }
    //   if (indexSong.value == trackList.length - 1) {
    //     indexSong.value = 0;
    //   }
    //   indexSong.value = indexSong.value! + 1;
    //   updateData(trackList[indexSong.value!]);
    //   //Get.changeTheme(theme)
    // }
  }

  void backSong() async {
    await audioPlayer.seekToPrevious();

    // if (trackData.value == null) {
    //   return;
    // }
    // isPlaying.value = true;
    // if (indexSong.value != null) {
    //   if (trackList.length == 1) {
    //     updateData(trackList[indexSong.value ?? 0]);
    //     return;
    //   }
    //   if (indexSong.value == 0) {
    //     indexSong.value = trackList.length - 1;
    //   }
    //   indexSong.value = indexSong.value! - 1;
    //   updateData(trackList[indexSong.value!]);
    // }
  }

  void getLinkSong(BuildContext context, String link, double x) async {
    saveLink(link);

    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (builder) {
          return Wrap(
            children: [
              Container(
                height: 70,
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(16)),
                child: Center(
                  child: MyText(
                    text: translation().coppied,
                  ),
                ),
              ),
            ],
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

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}
