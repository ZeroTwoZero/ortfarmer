import 'package:flutter/material.dart';
import 'package:ortfarmer/components/commonscaffold.dart';
import 'package:ortfarmer/styles/colors.dart';

class CommonTabPage extends StatefulWidget {
  final List<Widget> _childWidget, _tabWidget;
  final int _lengthOfTabs;
  final TabController? controller;
  const CommonTabPage(this._lengthOfTabs, this._tabWidget, this._childWidget,
      {super.key, this.controller});

  @override
  State<CommonTabPage> createState() => _CommonTabPageState();
}

class _CommonTabPageState extends State<CommonTabPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: whiteColor,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: DefaultTabController(
          length: widget._lengthOfTabs,
          child: CommonScaffold(
            Expanded(
              child: TabBarView(
                controller: widget.controller,
                children: widget._childWidget,
              ),
            ),
            centeredScaffold: false,
            appBarWidget: TabBar(
              controller: widget.controller,
              labelColor: greenColor,
              unselectedLabelColor: grayColor,
              indicatorColor: greenColor,
              indicatorWeight: 5,
              tabs: widget._tabWidget,
            ),
          ),
        ),
      ),
    );
  }
}
