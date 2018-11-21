import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_messenger_challenge/chat_item_view.dart';
import 'package:flutter_messenger_challenge/common.dart';
import 'package:flutter_messenger_challenge/cupertino_home_page.dart';
import 'package:flutter_messenger_challenge/material_home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => PlatformApplication(runtimePlatform());
}

class PlatformApplication extends StatelessWidget {
  final RuntimePlatform _runtimePlatform;

  PlatformApplication(this._runtimePlatform);

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

  Widget buildRootView(List<TabViewState> tabs) {
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

  List<TabViewState> createTabs(RuntimePlatform runtimePlatform) {
    switch (runtimePlatform) {
      case RuntimePlatform.Android:
        return [
          TabViewState("Chats", Icons.chat_bubble),
          TabViewState("Contacts", Icons.person),
          TabViewState("Post", Icons.photo_camera),
          TabViewState("Settings", Icons.settings),
        ];
      case RuntimePlatform.iOS:
        return [
          TabViewState("Contacts", CupertinoIcons.person),
          TabViewState("Calls", CupertinoIcons.phone),
          TabViewState("Post", CupertinoIcons.photo_camera),
          TabViewState("Chats", CupertinoIcons.conversation_bubble),
          TabViewState("Settings", CupertinoIcons.settings),
        ];
      default:
        return [];
    }
  }

  Widget createPageView(TabViewState tab) => ListView.builder(
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
