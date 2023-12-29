import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';

class FeedPlayerControls extends StatelessWidget {
  const FeedPlayerControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FlickVideoProgressBar(
            flickProgressBarSettings: FlickProgressBarSettings(
              height: 4,
              handleRadius: 8,
              handleColor: Colors.white,
              backgroundColor: Colors.grey,
              bufferedColor: Colors.grey[600]!,
              playedColor: Colors.white,
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlickPlayToggle(
                size: 30,
              ),
              FlickSoundToggle(),
            ],
          ),
        ],
      ),
    );
  }
}
