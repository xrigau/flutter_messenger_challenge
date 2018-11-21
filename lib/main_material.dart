import 'package:flutter/material.dart';
import 'package:flutter_messenger_challenge/chat_item_view.dart';

//void main() => runApp(MyMaterialApp());

class MyMaterialApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MaterialHomePage(),
    );
  }
}

class MaterialHomePage extends StatelessWidget {
  final List<Tab> _tabs = [
    Tab("Chats", Icons.chat_bubble),
    Tab("Contacts", Icons.person),
    Tab("Post", Icons.photo_camera),
    Tab("Settings", Icons.settings),
  ];

  final List<ChatItemViewState> _viewStates = generateMockViewStates(100);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Chats"),
          bottom: TabBar(
            tabs: _tabs.map(_createTabView).toList(),
          ),
        ),
        body: TabBarView(
          children: _tabs.map(createPageView).toList(),
        ),
      ),
    );
  }

  Widget _createTabView(tab) => Icon(tab.icon);

  Widget createPageView(Tab tab) {
    return ListView.builder(
      itemBuilder: createItemView,
      itemCount: _viewStates.length,
    );
  }

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

class Tab {
  final String title;
  final IconData icon;

  Tab(this.title, this.icon);
}
