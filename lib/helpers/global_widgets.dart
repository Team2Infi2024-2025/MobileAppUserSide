

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Settings/settings.dart';
import '../startup/custom_themes.dart';

class GlobalWidgets{


  static PageRoute swipePage(Widget destination,
      {bool appBar = false, String? title}) {
    if (title != null) {
      appBar = true;
    }
    return CupertinoPageRoute(
        builder: (context) => GestureDetector(
            child: appBar
                ? Scaffold(
              appBar: AppBar(
                shadowColor: Theme.of(context).colorScheme.shadow,
                elevation: 4,
                forceMaterialTransparency: title == null,
                backgroundColor:
                Theme.of(context).colorScheme.tertiaryContainer,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Theme.of(context).colorScheme.onSurface,
                    size: 25,
                  ),
                ),
                centerTitle: true,
                title: Text(title ?? '',
                    style: TextStyle(
                        color:
                            Theme.of(context).colorScheme.primary,
                        fontFamily: 'Georama',
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                        height: 0.85)),
              ),
              extendBodyBehindAppBar: title == null,
              body: destination,
            )
                : destination,
            onHorizontalDragEnd: (details) => {
              if (details.primaryVelocity! > 0) {Navigator.pop(context)}
            }));
  }




}