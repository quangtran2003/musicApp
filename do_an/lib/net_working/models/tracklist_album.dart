// To parse this JSON data, do
//
//     final tracklistAlbumModel = tracklistAlbumModelFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

String tracklistAlbumModelToJson(TracklistAlbumModel data) =>
    json.encode(data.toJson());

class TracklistAlbumModel {
  List<Datum>? data;
  int? total;

  TracklistAlbumModel({
    this.data,
    this.total,
  });

  factory TracklistAlbumModel.fromJson(Map<String, dynamic> json) =>
      TracklistAlbumModel(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "total": total,
      };
}

class Datum {
  int? id;
  bool? readable;
  String? title;
  String? titleShort;
  String? isrc;
  String? link;
  int? duration;
  int? trackPosition;
  int? diskNumber;
  int? rank;
  bool? explicitLyrics;
  int? explicitContentLyrics;
  int? explicitContentCover;
  String? preview;
  Artist? artist;

  Datum({
    this.id,
    this.readable,
    this.title,
    this.titleShort,
    this.isrc,
    this.link,
    this.duration,
    this.trackPosition,
    this.diskNumber,
    this.rank,
    this.explicitLyrics,
    this.explicitContentLyrics,
    this.explicitContentCover,
    this.preview,
    this.artist,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        readable: json["readable"],
        title: json["title"],
        titleShort: json["title_short"],
        isrc: json["isrc"],
        link: json["link"],
        duration: json["duration"],
        trackPosition: json["track_position"],
        diskNumber: json["disk_number"],
        rank: json["rank"],
        explicitLyrics: json["explicit_lyrics"],
        explicitContentLyrics: json["explicit_content_lyrics"],
        explicitContentCover: json["explicit_content_cover"],
        preview: json["preview"],
        artist: json["artist"] == null ? null : Artist.fromJson(json["artist"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "readable": readable,
        "title": title,
        "title_short": titleShort,
        "isrc": isrc,
        "link": link,
        "duration": duration,
        "track_position": trackPosition,
        "disk_number": diskNumber,
        "rank": rank,
        "explicit_lyrics": explicitLyrics,
        "explicit_content_lyrics": explicitContentLyrics,
        "explicit_content_cover": explicitContentCover,
        "preview": preview,
        "artist": artist?.toJson(),
      };
}

class Artist {
  int? id;
  String? tracklist;

  Artist({
    this.id,
    this.tracklist,
  });

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        id: json["id"],
        tracklist: json["tracklist"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tracklist": tracklist,
      };
}

enum Name { TAYLOR_SWIFT }

final nameValues = EnumValues({"Taylor Swift": Name.TAYLOR_SWIFT});

enum ArtistType { ARTIST }

final artistTypeValues = EnumValues({"artist": ArtistType.ARTIST});

enum Md5Image { THE_5_BCED293_F3_A0568_A5_F5111_F92_CBCA47_F }

final md5ImageValues = EnumValues({
  "5bced293f3a0568a5f5111f92cbca47f":
      Md5Image.THE_5_BCED293_F3_A0568_A5_F5111_F92_CBCA47_F
});

enum TitleVersion { BONUS_TRACK, EMPTY }

final titleVersionValues = EnumValues(
    {"(bonus track)": TitleVersion.BONUS_TRACK, "": TitleVersion.EMPTY});

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
