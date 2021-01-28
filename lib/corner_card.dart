import 'package:flutter/material.dart';
import 'package:webinar_demo/data.dart';

const _cornerSize = 64.0;
const _cornerFacet = 16.0;
const _cardFacet = 16.0;
const _cardShift = 12.0;
const _cornerDist = 8.0;
const _strokeWidth = 1.0;

class CornerCard extends StatelessWidget {
  final Widget child;
  final double cornerSize;
  final EdgeInsets padding;
  final Widget icon;
  final bool border;
  const CornerCard({
    Key key,
    this.child,
    this.cornerSize = _cornerSize,
    this.padding = const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    this.icon,
    this.border = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (icon != null)
          SizedBox(
            height: cornerSize,
            width: cornerSize,
            child: CustomPaint(
              painter: _CornerPainter(),
              child: ClipPath(clipper: _CornerClipper(), child: Center(child: icon ?? Container())),
            ),
          ),
        if (icon == null)
          ClipPath(
            clipper: _CornerClipper(),
            child: Container(
              height: cornerSize,
              width: cornerSize,
              color: ColorRes.btnBackRed,
              child: Center(
                child: icon ?? Container(),
              ),
            ),
          ),
        Positioned.fill(
          child: ClipPath(
            clipper: _CardClipper(cornerSize),
            child: Container(color: ColorRes.btnBackRed),
          ),
        ),
        ClipPath(
          clipper: _CardClipper(cornerSize),
          child: Padding(
            padding: padding == EdgeInsets.zero
                ? EdgeInsets.zero
                : padding.copyWith(left: padding.left + _cardShift, top: padding.top + _cardShift),
            child: child ??
                Container(
                  height: 200,
                  width: 200,
                ),
          ),
        ),
        if (border)
          Positioned.fill(
            child: CustomPaint(
              painter: _CardPainter(cornerSize),
              child: Center(child: icon ?? Container()),
            ),
          ),
      ],
    );
  }

  static Path getCornerPath(Size size) {
    return Path()
      ..lineTo(0.0, size.height)
      ..lineTo(size.width - _cornerFacet, size.height)
      ..lineTo(size.width, size.height - _cornerFacet)
      ..lineTo(size.width, 0.0)
      ..close();
  }

  static Path getCardPath(Size size, double corner) {
    return Path()
      ..moveTo(corner + _cornerDist, _cardShift)
      ..lineTo(corner + _cornerDist, corner - _cornerFacet + _cornerDist / 2.0)
      ..lineTo(corner - _cornerFacet + _cornerDist / 2.0, corner + _cornerDist)
      ..lineTo(_cardShift, corner + _cornerDist)
      ..lineTo(_cardShift, size.height)
      ..lineTo(size.width - _cardFacet, size.height)
      ..lineTo(size.width, size.height - _cardFacet)
      ..lineTo(size.width, _cardShift)
      ..close();
  }
}

class _CornerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ColorRes.textRed
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth;
    final path = CornerCard.getCornerPath(size);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CornerPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(_CornerPainter oldDelegate) => false;
}

class _CornerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) => CornerCard.getCornerPath(size);

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _CardPainter extends CustomPainter {
  final double corner;

  _CardPainter(this.corner);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ColorRes.textRed
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth;
    final path = CornerCard.getCardPath(size, corner);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CardPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(_CardPainter oldDelegate) => false;
}

class _CardClipper extends CustomClipper<Path> {
  final double cornerSize;

  _CardClipper(this.cornerSize);
  @override
  Path getClip(Size size) => CornerCard.getCardPath(size, cornerSize);

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
