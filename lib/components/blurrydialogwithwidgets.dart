import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ortfarmer/styles/styles.dart';

class BlurryDialogWithWidgets extends StatelessWidget {
  final String title;
  final Widget content;

  const BlurryDialogWithWidgets(this.title, this.content, {super.key});

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
          content: content,
          actions: const [],
        ));
  }
}
