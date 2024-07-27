import '../../net_working/models/track.dart';

class ModelSongTransfer {
  final int? songId;
  final bool? isSongBottom;
  final List<TrackModel>? listTrack;
  final List<int?>? listIdSong;

  ModelSongTransfer({
    this.isSongBottom = false,
    this.songId,
    this.listTrack,
    this.listIdSong,
  });
}
