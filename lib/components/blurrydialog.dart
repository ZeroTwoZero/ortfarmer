import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ortfarmer/styles/styles.dart';

class BlurryDialog extends StatelessWidget {
  final String title;
  final String content;

  const BlurryDialog(this.title, this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Text(
            title,
            style: boldOpenSansBlackLargeSize,
          ),
          content: Text(
            content,
            style: openSansBlackMediumSize,
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Ok",
                style: boldOpenSansBlueSmallSize,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }
}
