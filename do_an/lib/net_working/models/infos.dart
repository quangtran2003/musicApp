// To parse this JSON data, do
//
//     final infosmodel = infosmodelFromJson(jsonString);

import 'dart:convert';

// Infosmodel infosmodelFromJson(String str) =>
//     Infosmodel.fromJson(json.decode(str));

String infosmodelToJson(Infosmodel data) => json.encode(data.toJson());

class Infosmodel {
  String? countryIso;
  String? country;
  bool? open;
  String? pop;
  String? uploadToken;
  int? uploadTokenLifetime;
  dynamic userToken;
  Hosts? hosts;
  Ads? ads;
  bool? hasPodcasts;
  List<dynamic>? offers;

  Infosmodel({
    this.countryIso,
    this.country,
    this.open,
    this.pop,
    this.uploadToken,
    this.uploadTokenLifetime,
    this.userToken,
    this.hosts,
    this.ads,
    this.hasPodcasts,
    this.offers,
  });

  factory Infosmodel.fromJson(Map<String, dynamic> json) => Infosmodel(
        countryIso: json["country_iso"],
        country: json["country"],
        open: json["open"],
        pop: json["pop"],
        uploadToken: json["upload_token"],
        uploadTokenLifetime: json["upload_token_lifetime"],
        userToken: json["user_token"],
        hosts: json["hosts"] == null ? null : Hosts.fromJson(json["hosts"]),
        ads: json["ads"] == null ? null : Ads.fromJson(json["ads"]),
        hasPodcasts: json["has_podcasts"],
        offers: json["offers"] == null
            ? []
            : List<dynamic>.from(json["offers"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "country_iso": countryIso,
        "country": country,
        "open": open,
        "pop": pop,
        "upload_token": uploadToken,
        "upload_token_lifetime": uploadTokenLifetime,
        "user_token": userToken,
        "hosts": hosts?.toJson(),
        "ads": ads?.toJson(),
        "has_podcasts": hasPodcasts,
        "offers":
            offers == null ? [] : List<dynamic>.from(offers!.map((x) => x)),
      };
}

class Ads {
  Audio? audio;
  Display? display;
  BigNativeAdsHome? bigNativeAdsHome;

  Ads({
    this.audio,
    this.display,
    this.bigNativeAdsHome,
  });

  factory Ads.fromJson(Map<String, dynamic> json) => Ads(
        audio: json["audio"] == null ? null : Audio.fromJson(json["audio"]),
        display:
            json["display"] == null ? null : Display.fromJson(json["display"]),
        bigNativeAdsHome: json["big_native_ads_home"] == null
            ? null
            : BigNativeAdsHome.fromJson(json["big_native_ads_home"]),
      );

  Map<String, dynamic> toJson() => {
        "audio": audio?.toJson(),
        "display": display?.toJson(),
        "big_native_ads_home": bigNativeAdsHome?.toJson(),
      };
}

class Audio {
  Default? audioDefault;

  Audio({
    this.audioDefault,
  });

  factory Audio.fromJson(Map<String, dynamic> json) => Audio(
        audioDefault:
            json["default"] == null ? null : Default.fromJson(json["default"]),
      );

  Map<String, dynamic> toJson() => {
        "default": audioDefault?.toJson(),
      };
}

class Default {
  int? start;
  int? interval;
  String? unit;

  Default({
    this.start,
    this.interval,
    this.unit,
  });

  factory Default.fromJson(Map<String, dynamic> json) => Default(
        start: json["start"],
        interval: json["interval"],
        unit: json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "start": start,
        "interval": interval,
        "unit": unit,
      };
}

class BigNativeAdsHome {
  Android? iphone;
  Android? ipad;
  Android? android;
  Android? androidTablet;

  BigNativeAdsHome({
    this.iphone,
    this.ipad,
    this.android,
    this.androidTablet,
  });

  factory BigNativeAdsHome.fromJson(Map<String, dynamic> json) =>
      BigNativeAdsHome(
        iphone:
            json["iphone"] == null ? null : Android.fromJson(json["iphone"]),
        ipad: json["ipad"] == null ? null : Android.fromJson(json["ipad"]),
        android:
            json["android"] == null ? null : Android.fromJson(json["android"]),
        androidTablet: json["android_tablet"] == null
            ? null
            : Android.fromJson(json["android_tablet"]),
      );

  Map<String, dynamic> toJson() => {
        "iphone": iphone?.toJson(),
        "ipad": ipad?.toJson(),
        "android": android?.toJson(),
        "android_tablet": androidTablet?.toJson(),
      };
}

class Android {
  bool? enabled;

  Android({
    this.enabled,
  });

  factory Android.fromJson(Map<String, dynamic> json) => Android(
        enabled: json["enabled"],
      );

  Map<String, dynamic> toJson() => {
        "enabled": enabled,
      };
}

class Display {
  Default? interstitial;

  Display({
    this.interstitial,
  });

  factory Display.fromJson(Map<String, dynamic> json) => Display(
        interstitial: json["interstitial"] == null
            ? null
            : Default.fromJson(json["interstitial"]),
      );

  Map<String, dynamic> toJson() => {
        "interstitial": interstitial?.toJson(),
      };
}

class Hosts {
  String? stream;
  String? images;

  Hosts({
    this.stream,
    this.images,
  });

  factory Hosts.fromJson(Map<String, dynamic> json) => Hosts(
        stream: json["stream"],
        images: json["images"],
      );

  Map<String, dynamic> toJson() => {
        "stream": stream,
        "images": images,
      };
}
