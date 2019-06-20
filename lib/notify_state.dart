library notify_state;

import 'package:flutter/material.dart';

class NotifyWidget extends StatefulWidget {
  NotifyWidget({Key key, @required ChangeNotifier notifier}):this.notifier = notifier, super(key: key);
  final ChangeNotifier notifier;
  noSuchMethod(Invocation invocation) {}
}

class NotifyState extends State {
  ChangeNotifier notifier;
  @override
  void initState() {
    super.initState();
    notifier = (widget as NotifyWidget).notifier;
    notifier.addListener(onChangeNotify);
  }

  void onChangeNotify() {
    setState(() {});
  }

  noSuchMethod(Invocation invocation) {}

  @override
  void dispose() {
    notifier.removeListener(onChangeNotify);
    super.dispose();
  }
}

