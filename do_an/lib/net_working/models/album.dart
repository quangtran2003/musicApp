// To parse this JSON data, do
//
//     final albumModel = albumModelFromJson(jsonString);

import 'dart:convert';

// AlbumModel albumModelFromJson(String str) =>
//     AlbumModel.fromJson(json.decode(str));

String albumModelToJson(AlbumModel data) => json.encode(data.toJson());

class AlbumModel {
  int? id;
  Title? title;
  String? upc;
  String? link;
  String? share;
  String? cover;
  String? coverSmall;
  String? coverMedium;
  String? coverBig;
  String? coverXl;
  Md5Image? md5Image;
  int? genreId;
  Genres? genres;
  String? label;
  int? nbTracks;
  int? duration;
  int? fans;
  DateTime? releaseDate;
  RecordTypeEnum? recordType;
  bool? available;
  String? tracklist;
  bool? explicitLyrics;
  int? explicitContentLyrics;
  int? explicitContentCover;
  List<Contributor>? contributors;
  Artist? artist;
  RecordTypeEnum? type;
  Tracks? tracks;

  AlbumModel({
    this.id,
    this.title,
    this.upc,
    this.link,
    this.share,
    this.cover,
    this.coverSmall,
    this.coverMedium,
    this.coverBig,
    this.coverXl,
    this.md5Image,
    this.genreId,
    this.genres,
    this.label,
    this.nbTracks,
    this.duration,
    this.fans,
    this.releaseDate,
    this.recordType,
    this.available,
    this.tracklist,
    this.explicitLyrics,
    this.explicitContentLyrics,
    this.explicitContentCover,
    this.contributors,
    this.artist,
    this.type,
    this.tracks,
  });

  factory AlbumModel.fromJson(Map<String, dynamic> json) => AlbumModel(
        id: json["id"],
        title: titleValues.map[json["title"]]!,
        upc: json["upc"],
        link: json["link"],
        share: json["share"],
        cover: json["cover"],
        coverSmall: json["cover_small"],
        coverMedium: json["cover_medium"],
        coverBig: json["cover_big"],
        coverXl: json["cover_xl"],
        md5Image: md5ImageValues.map[json["md5_image"]]!,
        genreId: json["genre_id"],
        genres: json["genres"] == null ? null : Genres.fromJson(json["genres"]),
        label: json["label"],
        nbTracks: json["nb_tracks"],
        duration: json["duration"],
        fans: json["fans"],
        releaseDate: json["release_date"] == null
            ? null
            : DateTime.parse(json["release_date"]),
        recordType: recordTypeEnumValues.map[json["record_type"]]!,
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
        type: recordTypeEnumValues.map[json["type"]]!,
        tracks: json["tracks"] == null ? null : Tracks.fromJson(json["tracks"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": titleValues.reverse[title],
        "upc": upc,
        "link": link,
        "share": share,
        "cover": cover,
        "cover_small": coverSmall,
        "cover_medium": coverMedium,
        "cover_big": coverBig,
        "cover_xl": coverXl,
        "md5_image": md5ImageValues.reverse[md5Image],
        "genre_id": genreId,
        "genres": genres?.toJson(),
        "label": label,
        "nb_tracks": nbTracks,
        "duration": duration,
        "fans": fans,
        "release_date":
            "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "record_type": recordTypeEnumValues.reverse[recordType],
        "available": available,
        "tracklist": tracklist,
        "explicit_lyrics": explicitLyrics,
        "explicit_content_lyrics": explicitContentLyrics,
        "explicit_content_cover": explicitContentCover,
        "contributors": contributors == null
            ? []
            : List<dynamic>.from(contributors!.map((x) => x.toJson())),
        "artist": artist?.toJson(),
        "type": recordTypeEnumValues.reverse[type],
        "tracks": tracks?.toJson(),
      };
}

class Artist {
  int? id;
  Name? name;
  String? picture;
  String? pictureSmall;
  String? pictureMedium;
  String? pictureBig;
  String? pictureXl;
  String? tracklist;
  ArtistType? type;

  Artist({
    this.id,
    this.name,
    this.picture,
    this.pictureSmall,
    this.pictureMedium,
    this.pictureBig,
    this.pictureXl,
    this.tracklist,
    this.type,
  });

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        id: json["id"],
        name: nameValues.map[json["name"]]!,
        picture: json["picture"],
        pictureSmall: json["picture_small"],
        pictureMedium: json["picture_medium"],
        pictureBig: json["picture_big"],
        pictureXl: json["picture_xl"],
        tracklist: json["tracklist"],
        type: artistTypeValues.map[json["type"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "picture": picture,
        "picture_small": pictureSmall,
        "picture_medium": pictureMedium,
        "picture_big": pictureBig,
        "picture_xl": pictureXl,
        "tracklist": tracklist,
        "type": artistTypeValues.reverse[type],
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
  Name? name;
  String? link;
  String? share;
  String? picture;
  String? pictureSmall;
  String? pictureMedium;
  String? pictureBig;
  String? pictureXl;
  bool? radio;
  String? tracklist;
  ArtistType? type;
  String? role;

  Contributor({
    this.id,
    this.name,
    this.link,
    this.share,
    this.picture,
    this.pictureSmall,
    this.pictureMedium,
    this.pictureBig,
    this.pictureXl,
    this.radio,
    this.tracklist,
    this.type,
    this.role,
  });

  factory Contributor.fromJson(Map<String, dynamic> json) => Contributor(
        id: json["id"],
        name: nameValues.map[json["name"]]!,
        link: json["link"],
        share: json["share"],
        picture: json["picture"],
        pictureSmall: json["picture_small"],
        pictureMedium: json["picture_medium"],
        pictureBig: json["picture_big"],
        pictureXl: json["picture_xl"],
        radio: json["radio"],
        tracklist: json["tracklist"],
        type: artistTypeValues.map[json["type"]]!,
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "link": link,
        "share": share,
        "picture": picture,
        "picture_small": pictureSmall,
        "picture_medium": pictureMedium,
        "picture_big": pictureBig,
        "picture_xl": pictureXl,
        "radio": radio,
        "tracklist": tracklist,
        "type": artistTypeValues.reverse[type],
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
  Name? name;
  String? picture;
  ArtistType? type;
  String? tracklist;

  ArtistElement({
    this.id,
    this.name,
    this.picture,
    this.type,
    this.tracklist,
  });

  factory ArtistElement.fromJson(Map<String, dynamic> json) => ArtistElement(
        id: json["id"],
        name: nameValues.map[json["name"]]!,
        picture: json["picture"],
        type: artistTypeValues.map[json["type"]]!,
        tracklist: json["tracklist"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "picture": picture,
        "type": artistTypeValues.reverse[type],
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
  TitleVersion? titleVersion;
  String? link;
  int? duration;
  int? rank;
  bool? explicitLyrics;
  int? explicitContentLyrics;
  int? explicitContentCover;
  String? preview;
  Md5Image? md5Image;
  ArtistElement? artist;
  Album? album;
  PurpleType? type;

  TracksDatum({
    this.id,
    this.readable,
    this.title,
    this.titleShort,
    this.titleVersion,
    this.link,
    this.duration,
    this.rank,
    this.explicitLyrics,
    this.explicitContentLyrics,
    this.explicitContentCover,
    this.preview,
    this.md5Image,
    this.artist,
    this.album,
    this.type,
  });

  factory TracksDatum.fromJson(Map<String, dynamic> json) => TracksDatum(
        id: json["id"],
        readable: json["readable"],
        title: json["title"],
        titleShort: json["title_short"],
        titleVersion: titleVersionValues.map[json["title_version"]]!,
        link: json["link"],
        duration: json["duration"],
        rank: json["rank"],
        explicitLyrics: json["explicit_lyrics"],
        explicitContentLyrics: json["explicit_content_lyrics"],
        explicitContentCover: json["explicit_content_cover"],
        preview: json["preview"],
        md5Image: md5ImageValues.map[json["md5_image"]]!,
        artist: json["artist"] == null
            ? null
            : ArtistElement.fromJson(json["artist"]),
        album: json["album"] == null ? null : Album.fromJson(json["album"]),
        type: purpleTypeValues.map[json["type"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "readable": readable,
        "title": title,
        "title_short": titleShort,
        "title_version": titleVersionValues.reverse[titleVersion],
        "link": link,
        "duration": duration,
        "rank": rank,
        "explicit_lyrics": explicitLyrics,
        "explicit_content_lyrics": explicitContentLyrics,
        "explicit_content_cover": explicitContentCover,
        "preview": preview,
        "md5_image": md5ImageValues.reverse[md5Image],
        "artist": artist?.toJson(),
        "album": album?.toJson(),
        "type": purpleTypeValues.reverse[type],
      };
}

class Album {
  int? id;
  Title? title;
  String? cover;
  String? coverSmall;
  String? coverMedium;
  String? coverBig;
  String? coverXl;
  Md5Image? md5Image;
  String? tracklist;
  RecordTypeEnum? type;

  Album({
    this.id,
    this.title,
    this.cover,
    this.coverSmall,
    this.coverMedium,
    this.coverBig,
    this.coverXl,
    this.md5Image,
    this.tracklist,
    this.type,
  });

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        id: json["id"],
        title: titleValues.map[json["title"]]!,
        cover: json["cover"],
        coverSmall: json["cover_small"],
        coverMedium: json["cover_medium"],
        coverBig: json["cover_big"],
        coverXl: json["cover_xl"],
        md5Image: md5ImageValues.map[json["md5_image"]]!,
        tracklist: json["tracklist"],
        type: recordTypeEnumValues.map[json["type"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": titleValues.reverse[title],
        "cover": cover,
        "cover_small": coverSmall,
        "cover_medium": coverMedium,
        "cover_big": coverBig,
        "cover_xl": coverXl,
        "md5_image": md5ImageValues.reverse[md5Image],
        "tracklist": tracklist,
        "type": recordTypeEnumValues.reverse[type],
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
