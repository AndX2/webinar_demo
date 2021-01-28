import 'package:flutter/material.dart';

const _spSw600 = .6;

extension ContextExt on BuildContext {
  double get scHeight => MediaQuery.of(this).size.height;
  double get scWidth => MediaQuery.of(this).size.width;
  bool get sw600 => this.scWidth <= 600.0;

  TextStyle sp(TextStyle style) => style.copyWith(fontSize: this.sw600 ? style.fontSize * _spSw600 : null);
}
