import 'package:flutter/material.dart';
import 'package:webinar_demo/data.dart';
import 'package:webinar_demo/util.dart';

const _btnHeight = 104.0;
const _btnPadding = const EdgeInsets.symmetric(horizontal: 36.0, vertical: 12.0);
const _upPathShift = 12.0;

class PrimaryBtn extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double height;
  final EdgeInsets padding;
  final bool expand;
  final Color markerColor;
  final Widget prefix;

  const PrimaryBtn({
    this.onPressed,
    this.child,
    this.height = _btnHeight,
    this.padding = _btnPadding,
    this.expand = false,
    this.markerColor = ColorRes.btnBackRed,
    this.prefix,
    Key key,
  }) : super(key: key);

  PrimaryBtn.legendary({
    this.onPressed,
    this.child,
    this.height = _btnHeight,
    this.padding = _btnPadding,
    this.expand = false,
    this.markerColor = ColorRes.legendary,
    this.prefix,
    Key key,
  }) : super(key: key);

  PrimaryBtn.epic({
    this.onPressed,
    this.child,
    this.height = _btnHeight,
    this.padding = _btnPadding,
    this.expand = false,
    this.markerColor = ColorRes.epic,
    this.prefix,
    Key key,
  }) : super(key: key);

  PrimaryBtn.unusual({
    this.onPressed,
    this.child,
    this.height = _btnHeight,
    this.padding = _btnPadding,
    this.expand = false,
    this.markerColor = ColorRes.unusual,
    this.prefix,
    Key key,
  }) : super(key: key);

  PrimaryBtn.regular({
    this.onPressed,
    this.child,
    this.height = _btnHeight,
    this.padding = _btnPadding,
    this.expand = false,
    this.markerColor = ColorRes.regular,
    this.prefix,
    Key key,
  }) : super(key: key);

  static Path markerPath(Size size) => Path()
    ..lineTo(size.width, 0.0)
    ..lineTo(size.width, size.height)
    ..lineTo(0.0, size.height)
    ..lineTo(0.0, size.height * .85)
    ..lineTo(size.width * .15, size.height * .85)
    ..lineTo(size.width * .15, size.height * .6)
    ..lineTo(0.0, size.height * .6)
    ..close();

  static Path bodyPath(Size size) => Path()
    ..lineTo(0.0, size.height)
    ..lineTo(size.width - size.height * .25, size.height)
    ..lineTo(size.width, size.height * .75)
    ..lineTo(size.width, _upPathShift)
    ..lineTo(size.width / 3.0, _upPathShift)
    ..lineTo(size.width / 3.0 - _upPathShift, 0.0)
    ..close();

  @override
  _PrimaryBtnState createState() => _PrimaryBtnState();
}

class _PrimaryBtnState extends State<PrimaryBtn> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    final markerWidth = context.sw600 ? 16.0 : 24.0;
    return Container(
      child: Row(
        mainAxisSize: widget.expand ? MainAxisSize.max : MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: widget.height),
          _buildPrefix(markerWidth),
          SizedBox(width: widget.prefix == null ? markerWidth / 3.0 : markerWidth / 2.0),
          _buildBody(),
        ],
      ),
    );
  }

  Widget _buildPrefix(double markerWidth) {
    return widget.prefix ??
        Stack(
          children: [
            ClipPath(
              clipper: _MarkerClipper(),
              child: Container(
                height: widget.height,
                width: markerWidth,
                color: widget.markerColor,
              ),
            ),
            if (widget.markerColor == ColorRes.btnBackRed)
              CustomPaint(
                painter: _MarkerPainter(),
                size: Size(markerWidth, double.infinity),
              )
          ],
        );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        ClipPath(
          clipper: _BodyClipper(),
          child: Container(
            color: ColorRes.btnBackRed,
            constraints: BoxConstraints.tightFor(height: widget.height),
            child: Padding(
              padding: widget.padding,
              child: widget.child ?? Container(),
            ),
          ),
        ),
        Positioned.fill(
          child: CustomPaint(
            painter: _BodyPainter(),
          ),
        ),
        if (isHover)
          Positioned.fill(
            child: CustomPaint(
              painter: _HoverPainter(),
            ),
          ),
        if (widget.onPressed != null)
          Positioned.fill(
              child: ClipPath(
            clipper: _BodyClipper(),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: ColorRes.splashBlue,
                onTap: widget.onPressed,
                onHover: (bool hover) {
                  setState(() {
                    isHover = hover;
                  });
                },
              ),
            ),
          )),
      ],
    );
  }
}

class _MarkerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return PrimaryBtn.markerPath(size);
  }

  @override
  bool shouldReclip(covariant _MarkerClipper oldClipper) => false;
}

const _strokeWidth = 1.0;

class _MarkerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ColorRes.textRed
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth;
    final path = PrimaryBtn.markerPath(size);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_MarkerPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(_MarkerPainter oldDelegate) => false;
}

class _BodyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return PrimaryBtn.bodyPath(size);
  }

  @override
  bool shouldReclip(covariant _BodyClipper oldClipper) => false;
}

class _BodyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ColorRes.textRed
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth;
    final path = PrimaryBtn.bodyPath(size);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_BodyPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(_BodyPainter oldDelegate) => false;
}

const _hoverLenght = 32.0;
const _hoverWidth = 8.0;

class _HoverPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ColorRes.textBlue
      ..style = PaintingStyle.fill
      ..strokeWidth = _hoverWidth;
    final shift = (_hoverWidth - _strokeWidth) / 2.0;
    final path = Path()
      ..moveTo(size.width - _hoverLenght, shift + _upPathShift)
      ..lineTo(size.width - shift, shift + _upPathShift)
      ..lineTo(size.width - shift, _hoverLenght + _upPathShift);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_HoverPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(_HoverPainter oldDelegate) => false;
}
