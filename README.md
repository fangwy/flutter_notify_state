# notify_state

* State sharing management of business objects.

## Using

* use NotifyObject with ChangeNotifier
* use StatefulWidget extends NotifyWidget
* use State extends NotifyState

```dart
class TestWidget extends NotifyWidget {
  TestWidget({Key key, @required ChangeNotifier notifier}):super(key: key, notifier:notifier);
  @override
  _TestWidgetState createState() => new _TestWidgetState();
}

class _TestWidgetState extends NotifyState {
}
```

* demo:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class TestNotify with ChangeNotifier {
  num _counter = 0;
  num get counter => _counter;
  set counter(num v) {
    _counter = v;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(
        title: 'Flutter Demo',
        data: new TestNotify(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title, this.data}) : super(key: key);

  final TestNotify data;
  final String title;

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TestNotify data;
  @override
  void initState() {
    super.initState();
    this.data = widget.data;
  }

  void _incrementCounter() {
    data.counter++;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new TestWidget(notifier:data),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }
}

class TestWidget extends NotifyWidget {
  TestWidget({Key key, @required ChangeNotifier notifier}):super(key: key, notifier:notifier);
  @override
  _TestWidgetState createState() => new _TestWidgetState();
}

class _TestWidgetState extends NotifyState {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
            'You have pushed the button this many times:',
          ),
          new Text(
            '${(notifier as TestNotify).counter}',
            style: Theme.of(context).textTheme.display1,
          ),
        ],
      ),
    );
  }
}

```