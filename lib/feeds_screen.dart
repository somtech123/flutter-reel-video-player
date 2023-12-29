import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feed_app/utils/mock_data.dart';
import 'package:flutter_feed_app/video_feed_screen.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({super.key});

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  SwiperController controller = SwiperController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List items = mockData['items'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Reel Feed'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Swiper(
              itemCount: items.length,
              controller: controller,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => VideoFeedScreen(
                videoUrl: items[index]['trailer_url'],
                image: items[index]["image"],
                title: items[index]["title"],
                controller: controller,
              ),
            )
          ],
        ),
      ),
    );
  }
}
