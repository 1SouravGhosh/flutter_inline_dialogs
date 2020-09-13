import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:inline_dialogs/inline_dialogs.dart';

GetIt locator = GetIt.instance;

void dialogSetupLocator() {
  locator.registerSingleton(DialogService());
}

void main() {
  dialogSetupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inline Dialogs Demo',
      debugShowCheckedModeBanner: false,
      builder: (context, widget) => Navigator(
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => DialogManager(
            dialogService: locator<DialogService>(),
            child: widget,
          ),
        ),
      ),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Inline Dialogs Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _rightBtn, _leftBtn = "";
  bool _showOptionText = false, _showConfirmText = false, _confirmBtn;
  DialogService _dialogService = locator<DialogService>();
  Timer _counter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text(" Option Dialog "),
                onPressed: () {
                  setState(() {
                    _showOptionText = true;
                    _showConfirmText = false;
                    _rightBtn = null;
                    _leftBtn = null;
                  });
                  var _dialogResponse = _dialogService.showDialog(
                      title: Icon(
                        Icons.code,
                        size: 50,
                        color: Colors.orange,
                      ),
                      content: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "Sample option dialog",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      dialogType: DialogType.option,
                      optionRight: "Right",
                      optionLeft: "Left");
                  _dialogResponse.then((value) {
                    setState(() {
                      _rightBtn = value.optionRight;
                      _leftBtn = value.optionLeft;
                    });
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text("Confirm Dialog"),
                onPressed: () {
                  setState(() {
                    _showConfirmText = true;
                    _showOptionText = false;
                    _confirmBtn = false;
                  });
                  var _dialogResponse = _dialogService.showDialog(
                      title: Icon(
                        Icons.done_outline,
                        size: 50,
                        color: Colors.green,
                      ),
                      content: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "Sample confirm dialog",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      dialogType: DialogType.confirm,
                      buttonText: "Done");
                  _dialogResponse.then((value) {
                    setState(() {
                      _confirmBtn = value.confirmed;
                    });
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text(" Waiter Dialog  "),
                onPressed: () async {
                  setState(() {
                    _showConfirmText = false;
                    _showOptionText = false;
                  });
                  var _timer = Timer.periodic(Duration(seconds: 1), (timer) {
                    setState(() {
                      _counter = timer;
                    });
                  });
                  _dialogService.showDialog(
                    title: Text(
                      "Sample waiter dialog",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    content: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: CupertinoActivityIndicator(
                        radius: 20,
                      ),
                    ),
                  );
                  await Future.delayed(Duration(seconds: 5));
                  setState(() {
                    _dialogService.dismissDialog();
                  });
                  _timer.cancel();
                },
              ),
            ),
            _showOptionText
                ? Padding(
                    padding: const EdgeInsets.only(top: 160.0),
                    child: Text(
                      'Left btn returns : $_leftBtn',
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                  )
                : Container(),
            _showOptionText
                ? Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      'Right btn Returns : $_rightBtn',
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                  )
                : Container(),
            _showConfirmText
                ? Padding(
                    padding: const EdgeInsets.only(top: 160.0),
                    child: Text(
                      'Confirm btn returns : $_confirmBtn',
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                  )
                : Container(),
            !_showConfirmText && !_showOptionText
                ? Padding(
                    padding: const EdgeInsets.only(top: 180.0),
                    child: Text(
                      'Counter: ${_counter?.tick}',
                      style: Theme.of(context).textTheme.headline4,
                      textAlign: TextAlign.center,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
