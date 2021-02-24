import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const _spSw600 = .6;

extension ContextExt on BuildContext {
  double get scHeight => MediaQuery.of(this).size.height;
  double get scWidth => MediaQuery.of(this).size.width;
  bool get sw600 => this.scWidth <= 600.0;

  TextStyle sp(TextStyle style) => style.copyWith(fontSize: this.sw600 ? style.fontSize * _spSw600 : null);
}

Image adaptiveImage(
  String src, {
  double width,
  double height,
  BoxFit fit,
}) {
  return kIsWeb
      ? Image.network(
          src,
          width: width,
          height: height,
          fit: fit,
        )
      : Image.asset(
          src,
          width: width,
          height: height,
          fit: fit,
        );
}

Widget adaptiveIcon(String src, {double width, double height, BoxFit fit, Color color}) {
  return kIsWeb
      ? Image.network(
          src,
          width: width,
          height: height,
          fit: fit,
          color: color,
        )
      : SvgPicture.asset(
          src,
          width: width,
          height: height,
          fit: fit ?? BoxFit.contain,
          color: color,
        );
}
