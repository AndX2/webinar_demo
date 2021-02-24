import 'package:flutter/material.dart';
import 'package:webinar_demo/conditional/youtube.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

YoutubeWidget getWidget(
  double height,
  double width,
  String url,
) =>
    YoutubeWidgetIo(url: url);

class YoutubeWidgetIo extends StatelessWidget implements YoutubeWidget {
  final double height;
  final double width;
  final String url;

  const YoutubeWidgetIo({Key key, this.url, this.height, this.width}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final id = YoutubePlayer.convertUrlToId(url);
    final _controller = YoutubePlayerController(initialVideoId: id);
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      // videoProgressIndicatorColor: Colors.amber,
      // progressColors: ProgressColors(
      //   playedColor: Colors.amber,
      //   handleColor: Colors.amberAccent,
      // ),
      // onReady () {
      //     _controller.addListener(listener);
      // },
    );
  }
}
