import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonListSong extends StatelessWidget {
  const SkeletonListSong({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return SkeletonListTile(
                leadingStyle: SkeletonAvatarStyle(
                    borderRadius: BorderRadius.circular(10),
                    width: 55,
                    height: 55),
                titleStyle: const SkeletonLineStyle(width: 200),
                subtitleStyle: const SkeletonLineStyle(),
              );
            }));
  }
}
