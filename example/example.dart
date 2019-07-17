import 'package:flutter/material.dart';
import 'package:notify_state/notify_state.dart';

void main() => runApp(MyApp());

class TestData extends ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;
  set counter(int v) {
    this._counter = v;
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
      home: MyHomePage(notifier: TestData()),
    );
  }
}

class MyHomePage extends NotifyWidget {
  MyHomePage({Key key, @required ChangeNotifier notifier})
      : super(key: key, notifier: notifier);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends NotifyState {

  void _incrementCounter(){
    (notifier as TestData).counter++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("title" + (notifier as TestData).counter.toString()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              (notifier as TestData).counter.toString(),
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), 
    );
  }
}
