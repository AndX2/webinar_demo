import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:webinar_demo/conditional/youtube.dart';

YoutubeWidget getWidget(
  double height,
  double width,
  String url,
) =>
    YoutubeWidgetWeb(
      url: url,
      height: height,
      width: width,
    );

class YoutubeWidgetWeb extends StatefulWidget implements YoutubeWidget {
  final double height;
  final double width;
  final String url;
  const YoutubeWidgetWeb({Key key, this.height = 500.0, this.width = 500.0, this.url}) : super(key: key);
  @override
  _YoutubeWidgetState createState() => _YoutubeWidgetState();
}

class _YoutubeWidgetState extends State<YoutubeWidgetWeb> {
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
