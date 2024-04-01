// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

class MySong extends StatelessWidget {
  final Widget? widget;
  final IconData? iconLeading;
  final String? subTitle;
  final String? title;
  final String? urlImage;
   const MySong(
      {Key? key, this.subTitle, this.title,this.widget=const Icon(
          Icons.navigate_next_outlined,
          size: 30,
        ), this.urlImage, this.iconLeading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return title==null? SizedBox():Container(
      child: ListTile(
        leading: iconLeading == null
            ? Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        image: NetworkImage(urlImage ??
                            'https://www.idevice.ro/wp-content/uploads/2015/06/Apple-Music-wallpaper-iPad-150x150.png'),
                        fit: BoxFit.cover)),
              )
            : Icon(iconLeading),
        trailing: widget,
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
