import 'dart:io';

import 'package:flutter/material.dart';

enum RuntimePlatform { Android, iOS, Unsupported }

RuntimePlatform runtimePlatform() {
  if (Platform.isAndroid) {
    return RuntimePlatform.Android;
  } else if (Platform.isIOS) {
    return RuntimePlatform.iOS;
  }
  return RuntimePlatform.Unsupported;
}

class TabViewState {
  final String title;
  final IconData icon;

  TabViewState(this.title, this.icon);
}

typedef TabPageBuilder = Widget Function(TabViewState tab);
