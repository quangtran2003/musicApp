// To parse this JSON data, do
//
//     final albumModel = albumModelFromJson(jsonString);

import 'dart:convert';

// AlbumModel albumModelFromJson(String str) =>
//     AlbumModel.fromJson(json.decode(str));

String albumModelToJson(AlbumModel data) => json.encode(data.toJson());

class AlbumModel {
  int? id;
  String? upc;
  String? link;
  String? share;
  String? cover;
  String? coverSmall;
  String? coverMedium;
  String? coverBig;
  String? coverXl;
  int? genreId;
  Genres? genres;
  String? label;
  int? nbTracks;
  int? duration;
  int? fans;
  DateTime? releaseDate;
  bool? available;
  String? tracklist;
  bool? explicitLyrics;
  int? explicitContentLyrics;
  int? explicitContentCover;
  List<Contributor>? contributors;
  Artist? artist;
  Tracks? tracks;

  AlbumModel({
    this.id,
    this.upc,
    this.link,
    this.share,
    this.cover,
    this.coverSmall,
    this.coverMedium,
    this.coverBig,
    this.coverXl,
    this.genreId,
    this.genres,
    this.label,
    this.nbTracks,
    this.duration,
    this.fans,
    this.releaseDate,
    this.available,
    this.tracklist,
    this.explicitLyrics,
    this.explicitContentLyrics,
    this.explicitContentCover,
    this.contributors,
    this.artist,
    this.tracks,
  });

  factory AlbumModel.fromJson(Map<String, dynamic> json) => AlbumModel(
        id: json["id"],
        upc: json["upc"],
        link: json["link"],
        share: json["share"],
        cover: json["cover"],
        coverSmall: json["cover_small"],
        coverMedium: json["cover_medium"],
        coverBig: json["cover_big"],
        coverXl: json["cover_xl"],
        genreId: json["genre_id"],
        genres: json["genres"] == null ? null : Genres.fromJson(json["genres"]),
        label: json["label"],
        nbTracks: json["nb_tracks"],
        duration: json["duration"],
        fans: json["fans"],
        releaseDate: json["release_date"] == null
            ? null
            : DateTime.parse(json["release_date"]),
        available: json["available"],
        tracklist: json["tracklist"],
        explicitLyrics: json["explicit_lyrics"],
        explicitContentLyrics: json["explicit_content_lyrics"],
        explicitContentCover: json["explicit_content_cover"],
        contributors: json["contributors"] == null
            ? []
            : List<Contributor>.from(
                json["contributors"]!.map((x) => Contributor.fromJson(x))),
        artist: json["artist"] == null ? null : Artist.fromJson(json["artist"]),
        tracks: json["tracks"] == null ? null : Tracks.fromJson(json["tracks"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "upc": upc,
        "link": link,
        "share": share,
        "cover": cover,
        "cover_small": coverSmall,
        "cover_medium": coverMedium,
        "cover_big": coverBig,
        "cover_xl": coverXl,
        "genre_id": genreId,
        "genres": genres?.toJson(),
        "label": label,
        "nb_tracks": nbTracks,
        "duration": duration,
        "fans": fans,
        "release_date":
            "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "available": available,
        "tracklist": tracklist,
        "explicit_lyrics": explicitLyrics,
        "explicit_content_lyrics": explicitContentLyrics,
        "explicit_content_cover": explicitContentCover,
        "contributors": contributors == null
            ? []
            : List<dynamic>.from(contributors!.map((x) => x.toJson())),
        "artist": artist?.toJson(),
        "tracks": tracks?.toJson(),
      };
}

class Artist {
  int? id;
  String? picture;
  String? pictureSmall;
  String? pictureMedium;
  String? pictureBig;
  String? pictureXl;
  String? tracklist;

  Artist({
    this.id,
    this.picture,
    this.pictureSmall,
    this.pictureMedium,
    this.pictureBig,
    this.pictureXl,
    this.tracklist,
  });

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        id: json["id"],
        picture: json["picture"],
        pictureSmall: json["picture_small"],
        pictureMedium: json["picture_medium"],
        pictureBig: json["picture_big"],
        pictureXl: json["picture_xl"],
        tracklist: json["tracklist"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "picture": picture,
        "picture_small": pictureSmall,
        "picture_medium": pictureMedium,
        "picture_big": pictureBig,
        "picture_xl": pictureXl,
        "tracklist": tracklist,
      };
}

enum Name { POP, SON_TUNG_M_TP }

final nameValues =
    EnumValues({"Pop": Name.POP, "Son Tung M-TP": Name.SON_TUNG_M_TP});

enum ArtistType { ARTIST, GENRE }

final artistTypeValues =
    EnumValues({"artist": ArtistType.ARTIST, "genre": ArtistType.GENRE});

class Contributor {
  int? id;
  String? link;
  String? share;
  String? picture;
  String? pictureSmall;
  String? pictureMedium;
  String? pictureBig;
  String? pictureXl;
  bool? radio;
  String? tracklist;
  String? role;

  Contributor({
    this.id,
    this.link,
    this.share,
    this.picture,
    this.pictureSmall,
    this.pictureMedium,
    this.pictureBig,
    this.pictureXl,
    this.radio,
    this.tracklist,
    this.role,
  });

  factory Contributor.fromJson(Map<String, dynamic> json) => Contributor(
        id: json["id"],
        link: json["link"],
        share: json["share"],
        picture: json["picture"],
        pictureSmall: json["picture_small"],
        pictureMedium: json["picture_medium"],
        pictureBig: json["picture_big"],
        pictureXl: json["picture_xl"],
        radio: json["radio"],
        tracklist: json["tracklist"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "link": link,
        "share": share,
        "picture": picture,
        "picture_small": pictureSmall,
        "picture_medium": pictureMedium,
        "picture_big": pictureBig,
        "picture_xl": pictureXl,
        "radio": radio,
        "tracklist": tracklist,
        "role": role,
      };
}

class Genres {
  List<ArtistElement>? data;

  Genres({
    this.data,
  });

  factory Genres.fromJson(Map<String, dynamic> json) => Genres(
        data: json["data"] == null
            ? []
            : List<ArtistElement>.from(
                json["data"]!.map((x) => ArtistElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ArtistElement {
  int? id;
  String? picture;
  String? tracklist;

  ArtistElement({
    this.id,
    this.picture,
    this.tracklist,
  });

  factory ArtistElement.fromJson(Map<String, dynamic> json) => ArtistElement(
        id: json["id"],
        picture: json["picture"],
        tracklist: json["tracklist"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "picture": picture,
        "tracklist": tracklist,
      };
}

enum Md5Image { THE_85819_BAA7_A17769500_F781_ED49028576 }

final md5ImageValues = EnumValues({
  "85819baa7a17769500f781ed49028576":
      Md5Image.THE_85819_BAA7_A17769500_F781_ED49028576
});

enum RecordTypeEnum { ALBUM }

final recordTypeEnumValues = EnumValues({"album": RecordTypeEnum.ALBUM});

enum Title { M_TP_M_TP }

final titleValues = EnumValues({"m-tp M-TP": Title.M_TP_M_TP});

class Tracks {
  List<TracksDatum>? data;

  Tracks({
    this.data,
  });

  factory Tracks.fromJson(Map<String, dynamic> json) => Tracks(
        data: json["data"] == null
            ? []
            : List<TracksDatum>.from(
                json["data"]!.map((x) => TracksDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class TracksDatum {
  int? id;
  bool? readable;
  String? title;
  String? titleShort;
  String? link;
  int? duration;
  int? rank;
  bool? explicitLyrics;
  int? explicitContentLyrics;
  int? explicitContentCover;
  String? preview;
  ArtistElement? artist;
  Album? album;

  TracksDatum({
    this.id,
    this.readable,
    this.title,
    this.titleShort,
    this.link,
    this.duration,
    this.rank,
    this.explicitLyrics,
    this.explicitContentLyrics,
    this.explicitContentCover,
    this.preview,
    this.artist,
    this.album,
  });

  factory TracksDatum.fromJson(Map<String, dynamic> json) => TracksDatum(
        id: json["id"],
        readable: json["readable"],
        title: json["title"],
        titleShort: json["title_short"],
        link: json["link"],
        duration: json["duration"],
        rank: json["rank"],
        explicitLyrics: json["explicit_lyrics"],
        explicitContentLyrics: json["explicit_content_lyrics"],
        explicitContentCover: json["explicit_content_cover"],
        preview: json["preview"],
        artist: json["artist"] == null
            ? null
            : ArtistElement.fromJson(json["artist"]),
        album: json["album"] == null ? null : Album.fromJson(json["album"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "readable": readable,
        "title": title,
        "title_short": titleShort,
        "link": link,
        "duration": duration,
        "rank": rank,
        "explicit_lyrics": explicitLyrics,
        "explicit_content_lyrics": explicitContentLyrics,
        "explicit_content_cover": explicitContentCover,
        "preview": preview,
        "artist": artist?.toJson(),
        "album": album?.toJson(),
      };
}

class Album {
  int? id;
  String? cover;
  String? coverSmall;
  String? coverMedium;
  String? coverBig;
  String? coverXl;
  String? tracklist;

  Album({
    this.id,
    this.cover,
    this.coverSmall,
    this.coverMedium,
    this.coverBig,
    this.coverXl,
    this.tracklist,
  });

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        id: json["id"],
        cover: json["cover"],
        coverSmall: json["cover_small"],
        coverMedium: json["cover_medium"],
        coverBig: json["cover_big"],
        coverXl: json["cover_xl"],
        tracklist: json["tracklist"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cover": cover,
        "cover_small": coverSmall,
        "cover_medium": coverMedium,
        "cover_big": coverBig,
        "cover_xl": coverXl,
        "tracklist": tracklist,
      };
}

enum TitleVersion { EMPTY, SLIM_V_REMIX }

final titleVersionValues = EnumValues(
    {"": TitleVersion.EMPTY, "(SlimV Remix)": TitleVersion.SLIM_V_REMIX});

enum PurpleType { TRACK }

final purpleTypeValues = EnumValues({"track": PurpleType.TRACK});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
