// To parse this JSON data, do
//
//     final albumModel = albumModelFromJson(jsonString);

import 'dart:convert';

String albumModelToJson(AlbumModel data) => json.encode(data.toJson());

class AlbumModel {
  int? id;
  String? title;
  String? upc;
  String? link;
  String? share;
  String? cover;
  String? coverSmall;
  String? coverMedium;
  String? coverBig;
  String? coverXl;
  String? md5Image;
  int? genreId;
  Genres? genres;
  String? label;
  int? nbTracks;
  int? duration;
  int? fans;
  DateTime? releaseDate;
  String? recordType;
  bool? available;
  String? tracklist;
  bool? explicitLyrics;
  int? explicitContentLyrics;
  int? explicitContentCover;
  List<Contributor>? contributors;
  Artist? artist;
  String? type;
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
        title: json["title"],
        upc: json["upc"],
        link: json["link"],
        share: json["share"],
        cover: json["cover"],
        coverSmall: json["cover_small"],
        coverMedium: json["cover_medium"],
        coverBig: json["cover_big"],
        coverXl: json["cover_xl"],
        md5Image: json["md5_image"],
        genreId: json["genre_id"],
        genres: json["genres"] == null ? null : Genres.fromJson(json["genres"]),
        label: json["label"],
        nbTracks: json["nb_tracks"],
        duration: json["duration"],
        fans: json["fans"],
        releaseDate: json["release_date"] == null
            ? null
            : DateTime.parse(json["release_date"]),
        recordType: json["record_type"],
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
        type: json["type"],
        tracks: json["tracks"] == null ? null : Tracks.fromJson(json["tracks"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "upc": upc,
        "link": link,
        "share": share,
        "cover": cover,
        "cover_small": coverSmall,
        "cover_medium": coverMedium,
        "cover_big": coverBig,
        "cover_xl": coverXl,
        "md5_image": md5Image,
        "genre_id": genreId,
        "genres": genres?.toJson(),
        "label": label,
        "nb_tracks": nbTracks,
        "duration": duration,
        "fans": fans,
        "release_date":
            "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "record_type": recordType,
        "available": available,
        "tracklist": tracklist,
        "explicit_lyrics": explicitLyrics,
        "explicit_content_lyrics": explicitContentLyrics,
        "explicit_content_cover": explicitContentCover,
        "contributors": contributors == null
            ? []
            : List<dynamic>.from(contributors!.map((x) => x.toJson())),
        "artist": artist?.toJson(),
        "type": type,
        "tracks": tracks?.toJson(),
      };
}

class Artist {
  int? id;
  String? name;
  String? picture;
  String? pictureSmall;
  String? pictureMedium;
  String? pictureBig;
  String? pictureXl;
  String? tracklist;
  String? type;

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
        name: json["name"],
        picture: json["picture"],
        pictureSmall: json["picture_small"],
        pictureMedium: json["picture_medium"],
        pictureBig: json["picture_big"],
        pictureXl: json["picture_xl"],
        tracklist: json["tracklist"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "picture": picture,
        "picture_small": pictureSmall,
        "picture_medium": pictureMedium,
        "picture_big": pictureBig,
        "picture_xl": pictureXl,
        "tracklist": tracklist,
        "type": type,
      };
}

class Contributor {
  int? id;
  String? name;
  String? link;
  String? share;
  String? picture;
  String? pictureSmall;
  String? pictureMedium;
  String? pictureBig;
  String? pictureXl;
  bool? radio;
  String? tracklist;
  String? type;
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
        name: json["name"],
        link: json["link"],
        share: json["share"],
        picture: json["picture"],
        pictureSmall: json["picture_small"],
        pictureMedium: json["picture_medium"],
        pictureBig: json["picture_big"],
        pictureXl: json["picture_xl"],
        radio: json["radio"],
        tracklist: json["tracklist"],
        type: json["type"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "link": link,
        "share": share,
        "picture": picture,
        "picture_small": pictureSmall,
        "picture_medium": pictureMedium,
        "picture_big": pictureBig,
        "picture_xl": pictureXl,
        "radio": radio,
        "tracklist": tracklist,
        "type": type,
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
  String? name;
  String? picture;
  String? type;
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
        name: json["name"],
        picture: json["picture"],
        type: json["type"],
        tracklist: json["tracklist"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "picture": picture,
        "type": type,
        "tracklist": tracklist,
      };
}

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
  String? titleVersion;
  String? link;
  int? duration;
  int? rank;
  bool? explicitLyrics;
  int? explicitContentLyrics;
  int? explicitContentCover;
  String? preview;
  String? md5Image;
  ArtistElement? artist;
  Album? album;
  String? type;

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
        titleVersion: json["title_version"],
        link: json["link"],
        duration: json["duration"],
        rank: json["rank"],
        explicitLyrics: json["explicit_lyrics"],
        explicitContentLyrics: json["explicit_content_lyrics"],
        explicitContentCover: json["explicit_content_cover"],
        preview: json["preview"],
        md5Image: json["md5_image"],
        artist: json["artist"] == null
            ? null
            : ArtistElement.fromJson(json["artist"]),
        album: json["album"] == null ? null : Album.fromJson(json["album"]),
        type: json["type"],
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
        "md5_image": md5Image,
        "artist": artist?.toJson(),
        "album": album?.toJson(),
        "type": type,
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
  String? type;

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
        type: json["type"],
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
        "type": type,
      };
}
