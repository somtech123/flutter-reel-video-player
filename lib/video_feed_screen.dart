import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feed_app/feed_control.dart';
import 'package:video_player/video_player.dart';

import 'package:visibility_detector/visibility_detector.dart';

import 'package:flick_video_player/flick_video_player.dart';

class VideoFeedScreen extends StatefulWidget {
  const VideoFeedScreen({
    super.key,
    required this.image,
    required this.title,
    required this.videoUrl,
    required this.controller,
  });

  final String videoUrl, title, image;
  final SwiperController controller;

  @override
  State<VideoFeedScreen> createState() => _VideoFeedScreenState();
}

class _VideoFeedScreenState extends State<VideoFeedScreen> {
  FlickManager? _flickManager;

  @override
  void initState() {
    _flickManager = FlickManager(
      videoPlayerController:
          VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
            ..addListener(() {
              //if video is mounted and the video duration is over move to the next video
              //else continue playing the video
              setState(() {
                if (_flickManager!.flickVideoManager!.videoPlayerController!
                        .value.position ==
                    _flickManager!.flickVideoManager!.videoPlayerController!
                        .value.duration) {
                  widget.controller.next();
                }
              });
            })
            ..setLooping(true),
      autoPlay: true,
    );

    super.initState();
  }

  @override
  void dispose() {
    _flickManager?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ObjectKey(_flickManager),
      onVisibilityChanged: (visibility) {
        if (visibility.visibleFraction == 0 && this.mounted) {
          _flickManager!.flickControlManager?.autoPause();
          debugPrint('not playing');
        } else if (visibility.visibleFraction == 1) {
          _flickManager!.flickControlManager?.autoResume();
          debugPrint('playing');
        }
      },
      child: ClipRect(
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            height: 450,
            width: MediaQuery.of(context).size.width,
            child: FlickVideoPlayer(
              flickManager: _flickManager!,
              flickVideoWithControls: const FlickVideoWithControls(
                controls: FeedPlayerControls(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
