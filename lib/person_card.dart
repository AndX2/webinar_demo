import 'package:flutter/material.dart';
import 'package:webinar_demo/data.dart';
import 'package:webinar_demo/util.dart';

const _imageSize = 240.0;
const _imageFacet = 32.0;
const _imageSide = 8.0;
const _imageStrokeWidth = 3.0;

const _childShift = 20.0;
const _childFacet = 40.0;
const _childSide = 12.0;
const _strokeWidth = 1.0;

class PersonCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final Widget image;
  final String name;
  final double imageSize;

  PersonCard({
    Key key,
    this.child,
    this.padding = const EdgeInsets.fromLTRB(32.0, 24.0, 16.0, 24.0),
    this.image,
    this.name,
    this.imageSize = _imageSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: context.sp(StyleRes.content32Blue)),
        SizedBox(height: 4.0),
        Stack(
          children: [
            if (child != null)
              Padding(
                padding: EdgeInsets.only(left: imageSize - _childShift, top: _childShift),
                child: CustomPaint(
                  painter: _ChildPainter(),
                  child: ClipPath(
                    clipper: _ChildClipper(),
                    child: Container(
                      color: ColorRes.msgBackBlue,
                      child: Padding(
                        padding: padding,
                        child: child,
                      ),
                    ),
                  ),
                ),
              ),
            SizedBox(
              height: imageSize,
              width: imageSize,
              child: CustomPaint(
                painter: _ImagePainter(),
                child: ClipPath(
                  clipper: _ImageClipper(),
                  child: image,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  static Path getImagePath(Size size) {
    return Path()
      ..lineTo(0.0, size.height)
      ..lineTo(_imageFacet * 2, size.height)
      ..lineTo(_imageFacet * 2 + _imageSide, size.height - _imageSide)
      ..lineTo(size.width - _imageFacet, size.height - _imageSide)
      ..lineTo(size.width, size.height - _imageSide - _imageFacet)
      ..lineTo(size.width, size.height * 0.6)
      ..lineTo(size.width - _imageSide, size.height * 0.6 - _imageSide)
      ..lineTo(size.width - _imageSide, size.height * 0.3 + _imageSide)
      ..lineTo(size.width, size.height * 0.3)
      ..lineTo(size.width, 0.0)
      ..close();
  }

  static Path getChildPath(Size size) {
    return Path()
      ..lineTo(0.0, size.height - _childFacet)
      ..lineTo(_childFacet, size.height)
      ..lineTo(size.width - _childSide, size.height)
      ..lineTo(size.width - _childSide, size.height * .7)
      ..lineTo(size.width, size.height * .7 - _childSide)
      ..lineTo(size.width, 0.0)
      ..lineTo(size.width * .7, 0.0)
      ..lineTo(size.width * .7 - _childSide, _childSide)
      ..lineTo(size.width * .3 + _childSide, _childSide)
      ..lineTo(size.width * .3, 0.0)
      ..close();
  }
}

class _ChildPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ColorRes.textBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth;
    final path = PersonCard.getChildPath(size);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_ChildPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(_ChildPainter oldDelegate) => false;
}

class _ChildClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return PersonCard.getChildPath(size);
  }

  @override
  bool shouldReclip(_ChildClipper oldClipper) => true;
}

class _ImagePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ColorRes.textRed
      ..style = PaintingStyle.stroke
      ..strokeWidth = _imageStrokeWidth;
    final path = PersonCard.getImagePath(size);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_ImagePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(_ImagePainter oldDelegate) => false;
}

class _ImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) => PersonCard.getImagePath(size);

  @override
  bool shouldReclip(_ImageClipper oldClipper) => false;
}
