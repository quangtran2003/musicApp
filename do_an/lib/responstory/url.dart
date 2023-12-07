// ignore_for_file: constant_identifier_names

class Url {
  String? playlistId;
  String? artistId;
  String? albumId;

  Url({
    this.playlistId,
    this.artistId,
    this.albumId,
  });
  static const getSearch = 'https://deezerdevs-deezer.p.rapidapi.com/search';
  static const getArtist = 'https://deezerdevs-deezer.p.rapidapi.com/artist/';
  static const getTrack = 'https://deezerdevs-deezer.p.rapidapi.com/track/';
  static const getAlbum = 'https://deezerdevs-deezer.p.rapidapi.com/album/';
  static const getPlaylist =
      'https://deezerdevs-deezer.p.rapidapi.com/playlist/';
  static const getChart = 'https://api.deezer.com/chart';
  String get getTrackListPlaylist {
    return 'https://api.deezer.com/playlist/$playlistId/tracks';
  }

  String get getTrackListAlbum {
    return 'https://api.deezer.com/album/$albumId/tracks';
  }

  String get getTrackListArtist {
    return 'https://api.deezer.com/artist/$artistId/top?limit=30';
  }
}

enum APIMethod { Get, Post, Delete, Put }
