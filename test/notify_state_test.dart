import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:notify_state/notify_state.dart';

void main() {
  test('notify_state', () {
    var notifier = TestNotify();
    var testWidget1 = TestNotifyWidget(notifier: notifier);
    testWidget1.state.testInit(testWidget1);
    var testWidget2 = TestNotifyWidget(notifier: notifier);
    testWidget2.state.testInit(testWidget1);
    notifier.counter++;
    assert(notifier.counter == testWidget1.state.count &&
        notifier.counter == testWidget2.state.count);
    testWidget1.state.sub();
    testWidget1.state.sub();
    testWidget1.state.sub();
    assert(notifier.counter == testWidget1.state.count &&
        notifier.counter == testWidget2.state.count);
    testWidget2.state.add();
    assert(notifier.counter == testWidget1.state.count &&
        notifier.counter == testWidget2.state.count);
  });
}

class TestNotify with ChangeNotifier {
  num _counter = 0;
  num get counter => _counter;
  set counter(num v) {
    _counter = v;
    notifyListeners();
  }
}

class TestNotifyWidget extends NotifyWidget {
  final _TestNotifyState state;
  TestNotifyWidget({Key key, @required ChangeNotifier notifier})
      : state = _TestNotifyState(),
        super(key: key, notifier: notifier);
}

class _TestNotifyState extends NotifyState {
  num count = 0;

  TestNotifyWidget widget;

  void testInit(TestNotifyWidget widget) {
    this.widget = widget;
    initState();
  }

  @protected
  void initState() {
    super.initState();
    update();
  }

  @protected
  void setState(VoidCallback fn) {
    update();
  }

  void update() {
    count = (notifier as TestNotify).counter;
  }

  void sub() {
    (notifier as TestNotify).counter--;
  }

  void add() {
    (notifier as TestNotify).counter++;
  }
}
