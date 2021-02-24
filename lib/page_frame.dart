import 'dart:math';
import 'package:flutter/material.dart';
import 'package:webinar_demo/data.dart';
import 'package:webinar_demo/main.dart';

const _topFacet = .15;
const _bottomFacet = .1;
const _strokeWidth = .6;

class PageFrame extends StatefulWidget {
  final int index;
  final Widget child;
  const PageFrame({
    Key key,
    @required this.index,
    @required this.child,
  }) : super(key: key);

  @override
  _PageFrameState createState() => _PageFrameState();

  static Path getPath(Size size) {
    return Path()
      ..lineTo(0.0, size.height * (1.0 - _bottomFacet))
      ..lineTo(size.height * _bottomFacet, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, size.height * _topFacet)
      ..lineTo(size.width - size.height * _topFacet, 0.0)
      ..close();
  }
}

class _PageFrameState extends State<PageFrame> {
  PageController pageController;
  double _page = 0.0;
  double _opacity = 1.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    pageController = MainScrollProvider.of(context).pageController;
    pageController.addListener(_listenPageController);
    if (widget.index != 0) _opacity = .2;
  }

  @override
  void dispose() {
    pageController.removeListener(_listenPageController);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _opacity,
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: PageFramePainter(),
            ),
          ),
          widget.child
        ],
      ),
    );
  }

  void _listenPageController() {
    _page = pageController.page;
    final opacity = min(1.0, 1.0 - .9 * (_page - widget.index).abs());
    if (opacity != _opacity) setState(() => _opacity = opacity);
  }
}

class PageFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = PageFrame.getPath(size);
    final paint = Paint()
      ..color = ColorRes.textBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(PageFramePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(PageFramePainter oldDelegate) => false;
}
