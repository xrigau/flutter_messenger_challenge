import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_messenger_challenge/chat_item_view.dart';

void main() => runApp(MyApp());

enum RuntimePlatform { Android, iOS, Unsupported }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Application(runtimePlatform());

  RuntimePlatform runtimePlatform() {
    if (Platform.isAndroid) {
      return RuntimePlatform.Android;
    } else if (Platform.isIOS) {
      return RuntimePlatform.iOS;
    }
    return RuntimePlatform.Unsupported;
  }
}

class Application extends StatelessWidget {
  final RuntimePlatform _runtimePlatform;

  Application(this._runtimePlatform);

  @override
  Widget build(BuildContext context) {
    var title = 'Flutter Demo';
    var homePage = HomePage(_runtimePlatform);
    switch (_runtimePlatform) {
      case RuntimePlatform.Android:
        return MaterialApp(
          title: title,
          home: homePage,
        );
      case RuntimePlatform.iOS:
        return CupertinoApp(
          title: title,
          home: homePage,
        );
      default:
        return Container();
    }
  }
}

class HomePage extends StatelessWidget {
  final RuntimePlatform _runtimePlatform;
  final List<ChatItemViewState> _viewStates = generateMockViewStates(100);

  HomePage(this._runtimePlatform);

  @override
  Widget build(BuildContext context) =>
      buildRootView(createTabs(_runtimePlatform));

  Widget buildRootView(List<Tab> tabs) {
    switch (_runtimePlatform) {
      case RuntimePlatform.Android:
        return MaterialHomePage(
          tabs,
          createPageView,
        );
      case RuntimePlatform.iOS:
        return CupertinoHomePage(
          tabs,
          createPageView,
        );
      default:
        return Container();
    }
  }

  List<Tab> createTabs(RuntimePlatform runtimePlatform) {
    switch (runtimePlatform) {
      case RuntimePlatform.Android:
        return [
          Tab("Chats", Icons.chat_bubble),
          Tab("Contacts", Icons.person),
          Tab("Post", Icons.photo_camera),
          Tab("Settings", Icons.settings),
        ];
      case RuntimePlatform.iOS:
        return [
          Tab("Contacts", CupertinoIcons.person),
          Tab("Calls", CupertinoIcons.phone),
          Tab("Post", CupertinoIcons.photo_camera),
          Tab("Chats", CupertinoIcons.conversation_bubble),
          Tab("Settings", CupertinoIcons.settings),
        ];
      default:
        return [];
    }
  }

  Widget createPageView(Tab tab) => ListView.builder(
        itemBuilder: createItemView,
        itemCount: _viewStates.length,
      );

  Widget createItemView(BuildContext context, int index) => Container(
        child: ChatItemView(_viewStates[index]),
        decoration: new BoxDecoration(
          border: new Border(
            bottom: new BorderSide(
              color: Colors.lightBlue,
            ),
          ),
        ),
      );
}

class MaterialHomePage extends StatelessWidget {
  final List<Tab> _tabs;
  final TabPageBuilder _tabPageBuilder;

  const MaterialHomePage(this._tabs, this._tabPageBuilder, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: _tabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Chats"),
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

class CupertinoHomePage extends StatelessWidget {
  final List<Tab> _tabs;
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
                  _tabPageBuilder(_tabs[index]),
                ],
              ),
            ),
      );

  BottomNavigationBarItem _createTab(Tab tab) => BottomNavigationBarItem(
        icon: Icon(tab.icon),
        title: Text(tab.title),
      );

  Widget createNavigationBar(Tab tab) => CupertinoNavigationBar(
        middle: Text(tab.title),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Edit'),
        ),
      );
}

class Tab {
  final String title;
  final IconData icon;

  Tab(this.title, this.icon);
}

typedef TabPageBuilder = Widget Function(Tab tab);
