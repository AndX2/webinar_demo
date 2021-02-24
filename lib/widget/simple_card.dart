import 'package:flutter/material.dart';
import 'package:webinar_demo/data.dart';

const _facet = 20.0;
const _side = 5.0;
const _strokeWidth = 1.0;

class SimpleCard extends StatefulWidget {
  final Widget child;
  final EdgeInsets padding;
  final VoidCallback onPressed;

  SimpleCard({
    Key key,
    this.child,
    this.padding = const EdgeInsets.all(8.0),
    this.onPressed,
  }) : super(key: key);

  @override
  _SimpleCardState createState() => _SimpleCardState();

  static Path getPath(Size size) {
    return Path()
      ..lineTo(0.0, size.height)
      ..lineTo(size.width - _facet, size.height)
      ..lineTo(size.width, size.height - _facet)
      ..lineTo(size.width, 0.0)
      ..lineTo(size.width * .7, 0.0)
      ..lineTo(size.width * .7 - _side, _side)
      ..lineTo(size.width * .3 + _side, _side)
      ..lineTo(size.width * .3, 0.0)
      ..close();
  }
}

class _SimpleCardState extends State<SimpleCard> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          painter: _SimplePainter(),
          child: ClipPath(
            clipper: _SimpleClipper(),
            child: Container(
                color: ColorRes.msgBackBlue,
                child: Padding(padding: widget.padding, child: Center(child: widget.child))),
          ),
        ),
        if (isHover)
          Positioned.fill(
            child: CustomPaint(
              painter: _HoverPainter(),
            ),
          ),
        Positioned.fill(
          child: ClipPath(
            clipper: _SimpleClipper(),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: ColorRes.splashBlue,
                onTap: () {
                  Scaffold.of(context).openEndDrawer();
                },
                onHover: (bool hover) {
                  setState(() {
                    isHover = hover;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SimplePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ColorRes.textBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth;
    final path = SimpleCard.getPath(size);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_SimplePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(_SimplePainter oldDelegate) => false;
}

class _SimpleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return SimpleCard.getPath(size);
  }

  @override
  bool shouldReclip(_SimpleClipper oldClipper) => true;
}

const _hoverLenght = 28.0;
const _hoverWidth = 4.0;

class _HoverPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ColorRes.textBlue
      ..style = PaintingStyle.fill
      ..strokeWidth = _hoverWidth;
    final path = Path()
      ..moveTo(size.width - _hoverWidth, _hoverLenght)
      ..lineTo(size.width - _hoverWidth, _hoverWidth)
      ..lineTo(size.width - _hoverLenght, _hoverWidth);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_HoverPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(_HoverPainter oldDelegate) => false;
}
