
import  'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 建立AppBar
    final appBar = AppBar(
      title: const Text('Flutter動畫'),
    );

    // 建立App的操作畫面
    final animationWrapper = _AnimationWrapper(
        GlobalKey<_AnimationWrapperState>(), true, 1.0);

    var btn = RaisedButton(
      child: const Text('漸入下一個', style: TextStyle(fontSize: 18, color: Colors.white),),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      color: Colors.lightBlue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onPressed: () {
        animationWrapper.setOpacity(0.0);
      },
    );

    final widget = Center(
      child: Container(
        child: Column(
          children: <Widget>[animationWrapper,
            Container(child: btn, margin: EdgeInsets.symmetric(vertical: 20),)],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );

    // 結合AppBar和App操作畫面
    final appHomePage = Scaffold(
      appBar: appBar,
      body: widget,
    );

    return appHomePage;
  }
}

class _AnimationWrapper extends StatefulWidget {
  final GlobalKey<_AnimationWrapperState> _key;
  double _op;
  bool _showFirst;

  _AnimationWrapper(this._key, this._showFirst, this._op): super (key: _key);

  @override
  State<StatefulWidget> createState() => _AnimationWrapperState();

  setOpacity(double _op) {
    _key.currentState?.setOpacity(10);
  }
}

class _AnimationWrapperState extends State<_AnimationWrapper> {
  @override
  Widget build(BuildContext context) {
    var w = AnimatedCrossFade(
        firstChild: Container(
          alignment: Alignment.center,
          child: const Text(
            'Flutter動畫',
            style: TextStyle(fontSize: 26),
          ),
          width: 500,
          height: 100,
        ),
        secondChild: Container(
          child: const Icon(
            Icons.mood,
            size: 100,
          ),
          width: 500,
          height: 100,
        ),
        crossFadeState: widget._showFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        duration: Duration(seconds: 1)
    );

    return w;
  }

  setOpacity(double i) {
    setState(() {
      widget._op = i;
      widget._showFirst = !widget._showFirst;
    });
  }
}