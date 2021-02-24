import 'dart:math';

import 'package:flutter/material.dart';
import 'package:webinar_demo/data.dart';
import 'package:webinar_demo/main.dart';
import 'package:webinar_demo/util.dart';

class GearLogo extends StatefulWidget {
  final double height;
  final double width;
  const GearLogo({
    Key key,
    this.height = 148.0,
    this.width = 148.0,
  }) : super(key: key);

  @override
  _GearLogoState createState() => _GearLogoState();
}

class _GearLogoState extends State<GearLogo> {
  ScrollController _scrollController;
  double _angle = 0.0;
  double _opacity = 1.0;
  double _oldOpacity = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollController = MainScrollProvider.of(context).scrollController;
    _scrollController.addListener(() {
      setState(() {
        _angle = _scrollController.offset / 300.0;
        _opacity = 1.0 - .85 * (min(_scrollController.offset / 300.0, 1.0));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      onHover: (bool hover) {
        setState(() {
          if (hover) {
            _oldOpacity = _opacity;
            _opacity = 1.0;
          } else {
            _opacity = _oldOpacity;
          }
        });
      },
      child: Container(
        child: Opacity(
          opacity: _opacity,
          child: SizedBox(
            height: widget.height,
            width: widget.width,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Transform.rotate(
                  angle: _angle,
                  child: adaptiveIcon(
                    IconRes.logo_gear,
                    fit: BoxFit.fill,
                  ),
                ),
                adaptiveIcon(
                  IconRes.logo_text,
                  fit: BoxFit.fill,
                  color: ColorRes.textRed,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
