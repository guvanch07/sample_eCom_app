import 'package:flutter/widgets.dart';

extension DismissKeyboard on Widget {
  Widget dismissKeyboardWidget() => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: this,
      );
}
