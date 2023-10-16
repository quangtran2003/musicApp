// To parse this JSON data, do
//
//     final tracklistArtistModel = tracklistArtistModelFromJson(jsonString);

import 'dart:convert';

// TracklistArtistModel tracklistArtistModelFromJson(String str) =>
//     TracklistArtistModel.fromJson(json.decode(str));

String tracklistArtistModelToJson(TracklistArtistModel data) =>
    json.encode(data.toJson());

class TracklistArtistModel {
  List<Datum>? data;
  int? total;

  TracklistArtistModel({
    this.data,
    this.total,
  });

  factory TracklistArtistModel.fromJson(Map<String, dynamic> json) =>
      TracklistArtistModel(
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
  String? titleVersion;
  String? link;
  int? duration;
  int? rank;
  bool? explicitLyrics;
  int? explicitContentLyrics;
  int? explicitContentCover;
  String? preview;
  List<Contributor>? contributors;
  String? md5Image;
  Artist? artist;
  Album? album;
  DatumType? type;

  Datum({
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
    this.contributors,
    this.md5Image,
    this.artist,
    this.album,
    this.type,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        readable: json["readable"],
        title: json["title"],
        titleShort: json["title_short"],
        titleVersion: json["title_version"],
        link: json["link"],
        duration: json["duration"],
        rank: json["rank"],
        explicitLyrics: json["explicit_lyrics"],
        explicitContentLyrics: json["explicit_content_lyrics"],
        explicitContentCover: json["explicit_content_cover"],
        preview: json["preview"],
        contributors: json["contributors"] == null
            ? []
            : List<Contributor>.from(
                json["contributors"]!.map((x) => Contributor.fromJson(x))),
        md5Image: json["md5_image"],
        artist: json["artist"] == null ? null : Artist.fromJson(json["artist"]),
        album: json["album"] == null ? null : Album.fromJson(json["album"]),
        type: datumTypeValues.map[json["type"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "readable": readable,
        "title": title,
        "title_short": titleShort,
        "title_version": titleVersion,
        "link": link,
        "duration": duration,
        "rank": rank,
        "explicit_lyrics": explicitLyrics,
        "explicit_content_lyrics": explicitContentLyrics,
        "explicit_content_cover": explicitContentCover,
        "preview": preview,
        "contributors": contributors == null
            ? []
            : List<dynamic>.from(contributors!.map((x) => x.toJson())),
        "md5_image": md5Image,
        "artist": artist?.toJson(),
        "album": album?.toJson(),
        "type": datumTypeValues.reverse[type],
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
  AlbumType? type;

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
        title: json["title"],
        cover: json["cover"],
        coverSmall: json["cover_small"],
        coverMedium: json["cover_medium"],
        coverBig: json["cover_big"],
        coverXl: json["cover_xl"],
        md5Image: json["md5_image"],
        tracklist: json["tracklist"],
        type: albumTypeValues.map[json["type"]]!,
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
        "type": albumTypeValues.reverse[type],
      };
}

enum AlbumType { ALBUM }

final albumTypeValues = EnumValues({"album": AlbumType.ALBUM});

class Artist {
  int? id;
  Name? name;
  String? tracklist;
  ArtistType? type;

  Artist({
    this.id,
    this.name,
    this.tracklist,
    this.type,
  });

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        id: json["id"],
        name: nameValues.map[json["name"]]!,
        tracklist: json["tracklist"],
        type: artistTypeValues.map[json["type"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "tracklist": tracklist,
        "type": artistTypeValues.reverse[type],
      };
}

enum Name { BOMATELA, ONIONN, SNOOP_DOGG, SON_TUNG_M_TP }

final nameValues = EnumValues({
  "BOMATELA": Name.BOMATELA,
  "Onionn": Name.ONIONN,
  "Snoop Dogg": Name.SNOOP_DOGG,
  "Son Tung M-TP": Name.SON_TUNG_M_TP
});

enum ArtistType { ARTIST }

final artistTypeValues = EnumValues({"artist": ArtistType.ARTIST});

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
  Role? role;

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
        role: roleValues.map[json["role"]]!,
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
        "role": roleValues.reverse[role],
      };
}

enum Role { FEATURED, MAIN }

final roleValues = EnumValues({"Featured": Role.FEATURED, "Main": Role.MAIN});

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
