import 'package:flutter/material.dart';
import '../styles/colors.dart';

class CommonScaffold extends StatelessWidget {
  final Widget _widget;
  final Widget? titleWidget;
  final Color bgColor;
  final bool centeredScaffold;
  final PreferredSizeWidget? appBarWidget;
  const CommonScaffold(this._widget,
      {this.bgColor = whiteColor,
      this.centeredScaffold = true,
      this.titleWidget,
      this.appBarWidget,
      Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var columnWidget = Column(
      mainAxisAlignment:
          centeredScaffold ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: <Widget>[_widget],
    );
    return Container(
      color: whiteColor,
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: appBarWidget,
          backgroundColor: bgColor,
          resizeToAvoidBottomInset: true,
          body: centeredScaffold ? Center(child: columnWidget) : columnWidget,
        ),
      ),
    );
  }
}
