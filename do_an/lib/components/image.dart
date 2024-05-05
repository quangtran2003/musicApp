import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget imageNetwork(
  String url, {
  bool isArtist = false,
  BoxFit? fit,
  Color? color,
  double? height,
  double? width,
  double? radiusBL = 8,
  double? radiusBR = 8,
  double? radiusTL = 8,
  double? radiusTR = 8,
  Alignment alignment = Alignment.center,
  ImageRepeat repeat = ImageRepeat.noRepeat,
  bool matchTextDirection = false,
  BlendMode? colorBlendMode,
  FilterQuality filterQuality = FilterQuality.low,
  Key? key,
}) {
  return CachedNetworkImage(
    imageUrl: url,
    imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(
        shape: isArtist ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: !isArtist
            ? BorderRadius.only(
                bottomLeft: Radius.circular(radiusBL ?? 8),
                bottomRight: Radius.circular(radiusBR ?? 8),
                topLeft: Radius.circular(radiusTL ?? 8),
                topRight: Radius.circular(radiusTR ?? 8))
            : null,
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
    ),
    fit: fit ?? BoxFit.cover,
    color: color,
    height: height,
    width: width,
    errorWidget: (context, object, stackTrace) {
      return SizedBox(
        height: double.infinity,
        child: Image.asset(
          'assets/bgSong.png',
          fit: fit ?? BoxFit.cover,
        ),
      );
    },
    filterQuality: filterQuality,
    key: key,
    progressIndicatorBuilder: (context, url, downloadProgress) {
      return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          shape: isArtist ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: !isArtist
              ? BorderRadius.only(
                  bottomLeft: Radius.circular(radiusBL ?? 8),
                  bottomRight: Radius.circular(radiusBR ?? 8),
                  topLeft: Radius.circular(radiusTL ?? 8),
                  topRight: Radius.circular(radiusTR ?? 8))
              : null,
        ),
        child: Shimmer.fromColors(
          baseColor: const Color.fromARGB(255, 162, 83, 176).withOpacity(0.1),
          highlightColor: Colors.purpleAccent.withOpacity(0.5),
          child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: isArtist ? BoxShape.circle : BoxShape.rectangle,
                borderRadius: !isArtist
                    ? BorderRadius.only(
                        bottomLeft: Radius.circular(radiusBL ?? 8),
                        bottomRight: Radius.circular(radiusBR ?? 8),
                        topLeft: Radius.circular(radiusTL ?? 8),
                        topRight: Radius.circular(radiusTR ?? 8))
                    : null,
              ),
              height: double.infinity,
              width: double.infinity),
        ),
      );
    },
  );
}
