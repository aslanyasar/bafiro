import 'package:flutter/material.dart';
import '../../widgets/video_player_widget.dart';
import '../../widgets/comment_bottom_sheet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showComments(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const CommentBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> reels = [
      {
        "title": "Cafe Müzik Gecesi",
        "video": "assets/videos/sample1.mp4",
        "business": "Cafe Luna",
        "avatar": "assets/images/business1.png",
        "likes": 0,
        "isLiked": false,
      },
      {
        "title": "Tiyatro Gecesi",
        "video": "assets/videos/sample2.mp4",
        "business": "Tiyatro İstanbul",
        "avatar": "assets/images/business2.png",
        "likes": 0,
        "isLiked": false,
      },
    ];

    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: reels.length,
      itemBuilder: (context, index) {
        final reel = reels[index];
        return Stack(
          children: [
            VideoPlayerWidget(videoUrl: reel["video"] ?? ""),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.04,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reel["title"] ?? "",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.2,
                      shadows: [
                        Shadow(blurRadius: 12, color: Colors.black, offset: Offset(0, 1))
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "@${reel["business"]}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      height: 1.2,
                      shadows: [
                        Shadow(blurRadius: 10, color: Colors.black, offset: Offset(0, 1))
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "İşletme",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.orangeAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 16,
              bottom: 100,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(reel["avatar"] ?? ""),
                  ),
                  const SizedBox(height: 16),
                  StatefulBuilder(
                    builder: (context, setState) {
                      bool isLiked = reel['isLiked'];
                      int likeCount = reel['likes'];

                      return Column(
                        children: [
                          IconButton(
                            icon: Icon(
                              isLiked ? Icons.favorite : Icons.favorite_border,
                              color: isLiked ? Colors.red : Colors.white,
                              size: 32,
                            ),
                            onPressed: () {
                              setState(() {
                                isLiked = !isLiked;
                                likeCount += isLiked ? 1 : -1;
                                reels[index]['isLiked'] = isLiked;
                                reels[index]['likes'] = likeCount;
                              });
                            },
                          ),
                          Text(
                            '$likeCount',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => _showComments(context),
                    child: Column(
                      children: const [
                        Icon(Icons.comment, color: Colors.white, size: 32),
                        SizedBox(height: 4),
                        Text("0", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: const [
                      Icon(Icons.share, color: Colors.white, size: 32),
                      SizedBox(height: 4),
                      Text("0", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

