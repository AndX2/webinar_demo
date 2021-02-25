import 'package:flutter/material.dart';
import 'package:webinar_demo/data.dart';

const _messageFacet = 16.0;
const _messageOffset = 8.0;
const _messageRightPart = 64.0;
const _strokeWidth = 1.0;

class MessageCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final Color background;
  const MessageCard({
    Key key,
    this.child,
    this.padding,
    this.background,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: ClipPath(
          clipper: MessageClipper(),
          child: Container(
            color: background ?? ColorRes.msgBackBlue,
          ),
        )),
        Positioned.fill(
            child: CustomPaint(
          painter: MessagePainter(),
        )),
        Padding(
          padding: padding ?? const EdgeInsets.fromLTRB(24.0, 20.0, _messageRightPart + 16.0, 12.0),
          child: child ?? Container(),
        ),
      ],
    );
  }

  static Path getPath(Size size) {
    return Path()
      ..moveTo(size.width, 0.0)
      ..lineTo(size.width, size.height)
      ..lineTo(_messageFacet, size.height)
      ..lineTo(0.0, size.height - _messageFacet)
      ..lineTo(0.0, _messageOffset)
      ..lineTo(size.width - _messageRightPart - _messageOffset, _messageOffset)
      ..lineTo(size.width - _messageRightPart, 0.0)
      ..close();
  }
}

class MessagePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = MessageCard.getPath(size);
    final paint = Paint()
      ..color = ColorRes.textBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(MessagePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(MessagePainter oldDelegate) => false;
}

class MessageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) => MessageCard.getPath(size);

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
