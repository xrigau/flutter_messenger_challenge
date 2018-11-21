import 'package:flutter/cupertino.dart';
import 'package:flutter_messenger_challenge/common.dart';

class CupertinoHomePage extends StatelessWidget {
  final List<TabViewState> _tabs;
  final TabPageBuilder _tabPageBuilder;

  const CupertinoHomePage(this._tabs, this._tabPageBuilder, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: _tabs.map(_createTab).toList(),
        ),
        tabBuilder: (BuildContext context, int index) => Container(
              color: CupertinoColors.white,
              child: Column(
                children: <Widget>[
                  createNavigationBar(_tabs[index]),
                  createPageView(_tabs[index]),
                ],
              ),
            ),
      );

  BottomNavigationBarItem _createTab(TabViewState tab) =>
      BottomNavigationBarItem(
        icon: Icon(tab.icon),
        title: Text(tab.title),
      );

  Widget createNavigationBar(TabViewState tab) => CupertinoNavigationBar(
        middle: Text(tab.title),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Edit'),
        ),
      );

  Widget createPageView(TabViewState tab) {
    return Expanded(
      child: _tabPageBuilder(tab),
    );
  }
}
