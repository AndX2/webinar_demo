import 'package:flutter/material.dart';

import 'package:webinar_demo/conditional/stub.dart'
    if (dart.library.html) 'package:webinar_demo/conditional/i_frame.dart'
    if (dart.library.io) 'package:webinar_demo/conditional/mobile.dart';

abstract class YoutubeWidget implements Widget {
  final double height;
  final double width;
  final String url;

  factory YoutubeWidget({
    Key key,
    double height,
    double width,
    String url,
  }) =>
      getWidget(height, width, url);
}
