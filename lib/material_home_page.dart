import 'package:flutter/material.dart';
import 'package:flutter_messenger_challenge/common.dart';

class MaterialHomePage extends StatelessWidget {
  final List<TabViewState> _tabs;
  final TabPageBuilder _tabPageBuilder;

  const MaterialHomePage(this._tabs, this._tabPageBuilder, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: _tabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Chat"),
            bottom: TabBar(
              tabs: _tabs.map(_createTabView).toList(),
            ),
          ),
          body: TabBarView(
            children: _tabs.map(_tabPageBuilder).toList(),
          ),
        ),
      );

  Widget _createTabView(tab) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(tab.icon),
      );
}
