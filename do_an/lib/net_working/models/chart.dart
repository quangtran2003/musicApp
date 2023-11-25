// To parse this JSON data, do
//
//     final chartModel = chartModelFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

// ChartModel chartModelFromJsonChart(Map<String, dynamic> str) {
//   return ChartModel.fromJson(str);
// }

String chartModelToJson(ChartModel data) => json.encode(data.toJson());

class ChartModel {
  Tracks? tracks;
  Albums? albums;
  Artists? artists;
  Playlists? playlists;
  Podcasts? podcasts;

  ChartModel({
    this.tracks,
    this.albums,
    this.artists,
    this.playlists,
    this.podcasts,
  });

  factory ChartModel.fromJson(Map<String, dynamic> json) => ChartModel(
        tracks: json["tracks"] == null ? null : Tracks.fromJson(json["tracks"]),
        albums: json["albums"] == null ? null : Albums.fromJson(json["albums"]),
        artists:
            json["artists"] == null ? null : Artists.fromJson(json["artists"]),
        playlists: json["playlists"] == null
            ? null
            : Playlists.fromJson(json["playlists"]),
        podcasts: json["podcasts"] == null
            ? null
            : Podcasts.fromJson(json["podcasts"]),
      );

  Map<String, dynamic> toJson() => {
        "tracks": tracks?.toJson(),
        "albums": albums?.toJson(),
        "artists": artists?.toJson(),
        "playlists": playlists?.toJson(),
        "podcasts": podcasts?.toJson(),
      };
}

class Albums {
  List<AlbumsDatum>? data;
  int? total;

  Albums({
    this.data,
    this.total,
  });

  factory Albums.fromJson(Map<String, dynamic> json) => Albums(
        data: json["data"] == null
            ? []
            : List<AlbumsDatum>.from(
                json["data"]!.map((x) => AlbumsDatum.fromJson(x))),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "total": total,
      };
}

class AlbumsDatum {
  int? id;
  String? title;
  String? link;
  String? cover;
  String? coverSmall;
  String? coverMedium;
  String? coverBig;
  String? coverXl;
  String? md5Image;

  String? tracklist;
  bool? explicitLyrics;
  int? position;
  ArtistElement? artist;

  AlbumsDatum({
    this.id,
    this.title,
    this.link,
    this.cover,
    this.coverSmall,
    this.coverMedium,
    this.coverBig,
    this.coverXl,
    this.md5Image,
    this.tracklist,
    this.explicitLyrics,
    this.position,
    this.artist,
  });

  factory AlbumsDatum.fromJson(Map<String, dynamic> json) => AlbumsDatum(
        id: json["id"],
        title: json["title"],
        link: json["link"],
        cover: json["cover"],
        coverSmall: json["cover_small"],
        coverMedium: json["cover_medium"],
        coverBig: json["cover_big"],
        coverXl: json["cover_xl"],
        md5Image: json["md5_image"],
        tracklist: json["tracklist"],
        explicitLyrics: json["explicit_lyrics"],
        position: json["position"],
        artist: json["artist"] == null
            ? null
            : ArtistElement.fromJson(json["artist"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "link": link,
        "cover": cover,
        "cover_small": coverSmall,
        "cover_medium": coverMedium,
        "cover_big": coverBig,
        "cover_xl": coverXl,
        "md5_image": md5Image,
        "tracklist": tracklist,
        "explicit_lyrics": explicitLyrics,
        "position": position,
        "artist": artist?.toJson(),
      };
}

class ArtistElement {
  int? id;
  String? name;
  String? link;
  String? picture;
  String? pictureSmall;
  String? pictureMedium;
  String? pictureBig;
  String? pictureXl;
  bool? radio;
  String? tracklist;

  int? position;

  ArtistElement({
    this.id,
    this.name,
    this.link,
    this.picture,
    this.pictureSmall,
    this.pictureMedium,
    this.pictureBig,
    this.pictureXl,
    this.radio,
    this.tracklist,
    this.position,
  });

  factory ArtistElement.fromJson(Map<String, dynamic> json) => ArtistElement(
        id: json["id"],
        name: json["name"],
        link: json["link"],
        picture: json["picture"],
        pictureSmall: json["picture_small"],
        pictureMedium: json["picture_medium"],
        pictureBig: json["picture_big"],
        pictureXl: json["picture_xl"],
        radio: json["radio"],
        tracklist: json["tracklist"],
        position: json["position"],
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
        "radio": radio,
        "tracklist": tracklist,
        "position": position,
      };
}

enum ArtistType { ARTIST }

final artistTypeValues = EnumValues({"artist": ArtistType.ARTIST});

enum RecordTypeEnum { ALBUM }

final recordTypeEnumValues = EnumValues({"album": RecordTypeEnum.ALBUM});

class Artists {
  List<ArtistElement>? data;
  int? total;

  Artists({
    this.data,
    this.total,
  });

  factory Artists.fromJson(Map<String, dynamic> json) => Artists(
        data: json["data"] == null
            ? []
            : List<ArtistElement>.from(
                json["data"]!.map((x) => ArtistElement.fromJson(x))),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "total": total,
      };
}

class Playlists {
  List<PlaylistsDatum>? data;
  int? total;

  Playlists({
    this.data,
    this.total,
  });

  factory Playlists.fromJson(Map<String, dynamic> json) => Playlists(
        data: json["data"] == null
            ? []
            : List<PlaylistsDatum>.from(
                json["data"]!.map((x) => PlaylistsDatum.fromJson(x))),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "total": total,
      };
}

class PlaylistsDatum {
  int? id;
  String? title;
  bool? public;
  int? nbTracks;
  String? link;
  String? picture;
  String? pictureSmall;
  String? pictureMedium;
  String? pictureBig;
  String? pictureXl;
  String? checksum;
  String? tracklist;
  DateTime? creationDate;
  String? md5Image;
  PictureTypeEnum? pictureType;
  User? user;

  PlaylistsDatum({
    this.id,
    this.title,
    this.public,
    this.nbTracks,
    this.link,
    this.picture,
    this.pictureSmall,
    this.pictureMedium,
    this.pictureBig,
    this.pictureXl,
    this.checksum,
    this.tracklist,
    this.creationDate,
    this.md5Image,
    this.pictureType,
    this.user,
  });

  factory PlaylistsDatum.fromJson(Map<String, dynamic> json) => PlaylistsDatum(
        id: json["id"],
        title: json["title"],
        public: json["public"],
        nbTracks: json["nb_tracks"],
        link: json["link"],
        picture: json["picture"],
        pictureSmall: json["picture_small"],
        pictureMedium: json["picture_medium"],
        pictureBig: json["picture_big"],
        pictureXl: json["picture_xl"],
        checksum: json["checksum"],
        tracklist: json["tracklist"],
        creationDate: json["creation_date"] == null
            ? null
            : DateTime.parse(json["creation_date"]),
        md5Image: json["md5_image"],
        pictureType: pictureTypeEnumValues.map[json["picture_type"]]!,
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "public": public,
        "nb_tracks": nbTracks,
        "link": link,
        "picture": picture,
        "picture_small": pictureSmall,
        "picture_medium": pictureMedium,
        "picture_big": pictureBig,
        "picture_xl": pictureXl,
        "checksum": checksum,
        "tracklist": tracklist,
        "creation_date": creationDate?.toIso8601String(),
        "md5_image": md5Image,
        "picture_type": pictureTypeEnumValues.reverse[pictureType],
        "user": user?.toJson(),
      };
}

enum PictureTypeEnum { PLAYLIST }

final pictureTypeEnumValues =
    EnumValues({"playlist": PictureTypeEnum.PLAYLIST});

class User {
  int? id;
  String? name;
  String? tracklist;

  User({
    this.id,
    this.name,
    this.tracklist,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        tracklist: json["tracklist"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "tracklist": tracklist,
      };
}

enum UserType { USER }

final userTypeValues = EnumValues({"user": UserType.USER});

class Podcasts {
  List<PodcastsDatum>? data;
  int? total;

  Podcasts({
    this.data,
    this.total,
  });

  factory Podcasts.fromJson(Map<String, dynamic> json) => Podcasts(
        data: json["data"] == null
            ? []
            : List<PodcastsDatum>.from(
                json["data"]!.map((x) => PodcastsDatum.fromJson(x))),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "total": total,
      };
}

class PodcastsDatum {
  int? id;
  String? title;
  String? description;
  bool? available;
  int? fans;
  String? link;
  String? share;
  String? picture;
  String? pictureSmall;
  String? pictureMedium;
  String? pictureBig;
  String? pictureXl;

  PodcastsDatum({
    this.id,
    this.title,
    this.description,
    this.available,
    this.fans,
    this.link,
    this.share,
    this.picture,
    this.pictureSmall,
    this.pictureMedium,
    this.pictureBig,
    this.pictureXl,
  });

  factory PodcastsDatum.fromJson(Map<String, dynamic> json) => PodcastsDatum(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        available: json["available"],
        fans: json["fans"],
        link: json["link"],
        share: json["share"],
        picture: json["picture"],
        pictureSmall: json["picture_small"],
        pictureMedium: json["picture_medium"],
        pictureBig: json["picture_big"],
        pictureXl: json["picture_xl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "available": available,
        "fans": fans,
        "link": link,
        "share": share,
        "picture": picture,
        "picture_small": pictureSmall,
        "picture_medium": pictureMedium,
        "picture_big": pictureBig,
        "picture_xl": pictureXl,
      };
}

enum PurpleType { PODCAST }

final purpleTypeValues = EnumValues({"podcast": PurpleType.PODCAST});

class Tracks {
  List<TracksDatum>? data;
  int? total;

  Tracks({
    this.data,
    this.total,
  });

  factory Tracks.fromJson(Map<String, dynamic> json) => Tracks(
        data: json["data"] == null
            ? []
            : List<TracksDatum>.from(
                json["data"]!.map((x) => TracksDatum.fromJson(x))),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "total": total,
      };
}

class TracksDatum {
  int? id;
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
  int? position;
  ArtistElement? artist;
  Album? album;

  TracksDatum({
    this.id,
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
    this.position,
    this.artist,
    this.album,
  });

  factory TracksDatum.fromJson(Map<String, dynamic> json) => TracksDatum(
        id: json["id"],
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
        position: json["position"],
        artist: json["artist"] == null
            ? null
            : ArtistElement.fromJson(json["artist"]),
        album: json["album"] == null ? null : Album.fromJson(json["album"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
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
        "position": position,
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

enum TitleVersion { EMPTY, TWIN_VER }

final titleVersionValues =
    EnumValues({"": TitleVersion.EMPTY, "(Twin Ver.)": TitleVersion.TWIN_VER});

enum FluffyType { TRACK }

final fluffyTypeValues = EnumValues({"track": FluffyType.TRACK});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
