import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model.dart';
import 'service.dart';

class DialogManager extends StatefulWidget {
  final DialogService dialogService;
  final Widget child;

  DialogManager({
    Key key,
    @required this.dialogService,
    @required this.child,
  })  : assert(dialogService != null),
        assert(child != null),
        super(key: key);

  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  @override
  void initState() {
    super.initState();
    widget.dialogService.registerDialogListener(_showDialog, _dismissDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _dismissDialog(DialogRequest request) {
    Navigator.of(context).pop();
  }

  void _showDialog(DialogRequest request) {
    showDialog(
        context: context,
        barrierDismissible: request.dialogType != DialogType.waiter,
        builder: (context) => CupertinoAlertDialog(
              title: request.title,
              content: request.description,
              actions: _buildButton(
                  dialogType: request.dialogType,
                  optionLeft: request.optionLeft,
                  optionRight: request.optionRight,
                  buttonText: request.buttonText),
            ));
  }

  List<CupertinoDialogAction> _buildButton({
    DialogType dialogType,
    String optionLeft,
    String optionRight,
    String buttonText,
  }) {
    switch (dialogType) {
      case DialogType.option:
        {
          return [
            CupertinoDialogAction(
              child: Text(
                optionLeft,
                style: TextStyle(color: Colors.blueAccent),
              ),
              onPressed: () {
                widget.dialogService.dialogComplete(
                    DialogResponse(optionLeft: optionLeft, confirmed: true));
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text(
                optionRight,
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                widget.dialogService.dialogComplete(
                    DialogResponse(optionRight: optionRight, confirmed: true));
                Navigator.of(context).pop();
              },
            )
          ];
        }
        break;
      case DialogType.confirm:
        {
          return [
            CupertinoDialogAction(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  buttonText,
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
              onPressed: () {
                widget.dialogService.dialogComplete(
                    DialogResponse(optionLeft: buttonText, confirmed: true));
                Navigator.of(context).pop();
              },
            )
          ];
        }
        break;
      case DialogType.waiter:
        {
          return [];
        }
        break;
    }
    return [];
  }
}
