import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class IframeScreen extends StatefulWidget {
  final double height;
  final double width;
  final String url;
  const IframeScreen({Key key, this.height = 500.0, this.width = 500.0, this.url}) : super(key: key);
  @override
  _IframeScreenState createState() => _IframeScreenState();
}

class _IframeScreenState extends State<IframeScreen> {
  Widget _iframeWidget;
  final IFrameElement _iframeElement = IFrameElement();
  @override
  void initState() {
    super.initState();
    _iframeElement.height = '${widget.height}';
    _iframeElement.width = '${widget.width}';

    _iframeElement.src = widget.url;
    _iframeElement.style.border = 'none';

    // ignore:undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'iframeElement',
      (int viewId) => _iframeElement,
    );
    _iframeWidget = HtmlElementView(
      key: UniqueKey(),
      viewType: 'iframeElement',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: _iframeWidget,
      ),
    );
  }
}
