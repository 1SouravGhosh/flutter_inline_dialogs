import 'package:flutter/cupertino.dart';

enum DialogType { option, confirm, waiter }

class DialogRequest {
  final Widget title;
  final Widget description;
  final DialogType dialogType;
  final String optionLeft;
  final String optionRight;
  final String buttonText;

  DialogRequest(
      {this.title,
      this.description,
      this.buttonText,
      this.optionRight,
      this.optionLeft,
      this.dialogType});
}

class DialogResponse {
  final String optionLeft;
  final String optionRight;
  final bool confirmed;

  DialogResponse({
    this.optionLeft,
    this.optionRight,
    this.confirmed = false,
  });
}
