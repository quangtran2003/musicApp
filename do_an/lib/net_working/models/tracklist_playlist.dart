// To parse this JSON data, do
//
//     final tracklistPlaylistModel = tracklistPlaylistModelFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

TracklistPlaylistModel trackListModelFromJson(Map<String, dynamic> str) =>
    TracklistPlaylistModel.fromJson(str);

String tracklistPlaylistModelToJson(TracklistPlaylistModel data) =>
    json.encode(data.toJson());

class TracklistPlaylistModel {
  List<Datum>? data;
  String? checksum;
  int? total;
  String? next;

  TracklistPlaylistModel({
    this.data,
    this.checksum,
    this.total,
    this.next,
  });

  factory TracklistPlaylistModel.fromJson(Map<String, dynamic> json) =>
      TracklistPlaylistModel(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        checksum: json["checksum"],
        total: json["total"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "checksum": checksum,
        "total": total,
        "next": next,
      };
}

class Datum {
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
  String? md5Image;
  int? timeAdd;
  Artist? artist;
  Album? album;

  Datum({
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
    this.md5Image,
    this.timeAdd,
    this.artist,
    this.album,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
        md5Image: json["md5_image"],
        timeAdd: json["time_add"],
        artist: json["artist"] == null ? null : Artist.fromJson(json["artist"]),
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
        "md5_image": md5Image,
        "time_add": timeAdd,
        "artist": artist?.toJson(),
        "album": album?.toJson(),
      };
}

class Album {
  int? id;
  String? title;
  String? cover;
  String? coverSmall;
  String? coverMedium;
  String? coverBig;
  String? coverXl;
  String? md5Image;
  String? tracklist;

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
  });

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        id: json["id"],
        title: json["title"],
        cover: json["cover"],
        coverSmall: json["cover_small"],
        coverMedium: json["cover_medium"],
        coverBig: json["cover_big"],
        coverXl: json["cover_xl"],
        md5Image: json["md5_image"],
        tracklist: json["tracklist"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "cover": cover,
        "cover_small": coverSmall,
        "cover_medium": coverMedium,
        "cover_big": coverBig,
        "cover_xl": coverXl,
        "md5_image": md5Image,
        "tracklist": tracklist,
      };
}

enum AlbumType { ALBUM }

final albumTypeValues = EnumValues({"album": AlbumType.ALBUM});

class Artist {
  int? id;
  String? name;
  String? link;
  String? picture;
  String? pictureSmall;
  String? pictureMedium;
  String? pictureBig;
  String? pictureXl;
  String? tracklist;

  Artist({
    this.id,
    this.name,
    this.link,
    this.picture,
    this.pictureSmall,
    this.pictureMedium,
    this.pictureBig,
    this.pictureXl,
    this.tracklist,
  });

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        id: json["id"],
        name: json["name"],
        link: json["link"],
        picture: json["picture"],
        pictureSmall: json["picture_small"],
        pictureMedium: json["picture_medium"],
        pictureBig: json["picture_big"],
        pictureXl: json["picture_xl"],
        tracklist: json["tracklist"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "link": link,
        "picture": picture,
        "picture_small": pictureSmall,
        "picture_medium": pictureMedium,
        "picture_big": pictureBig,
        "picture_xl": pictureXl,
        "tracklist": tracklist,
      };
}

enum ArtistType { ARTIST }

final artistTypeValues = EnumValues({"artist": ArtistType.ARTIST});

enum TitleVersion { EDIT, EMPTY, FROM_BARBIE_THE_ALBUM }

final titleVersionValues = EnumValues({
  "(Edit)": TitleVersion.EDIT,
  "": TitleVersion.EMPTY,
  "(From Barbie The Album)": TitleVersion.FROM_BARBIE_THE_ALBUM
});

enum DatumType { TRACK }

final datumTypeValues = EnumValues({"track": DatumType.TRACK});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
