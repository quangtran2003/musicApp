// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

class MySong extends StatelessWidget {
  final IconData? icon;
  final String? subTitle;
  final String? title;
  final String? url;
  const MySong({Key? key, this.subTitle, this.title, this.url, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: icon == null
            ? Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        image: NetworkImage(url ??
                            'https://www.idevice.ro/wp-content/uploads/2015/06/Apple-Music-wallpaper-iPad-150x150.png'),
                        fit: BoxFit.cover)),
              )
            : Icon(icon),
        trailing: const Icon(
          Icons.navigate_next_outlined,
          size: 30,
        ),
        subtitle: Text(subTitle ?? ''),
        title: Text(
          title ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
