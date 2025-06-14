import 'package:flutter/material.dart';
import '../../widgets/video_player_widget.dart';
import '../../widgets/user_info_block.dart';
import '../../widgets/comment_bottom_sheet.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> reels = [
    {
      "title": "Cafe Müzik Gecesi",
      "video": "assets/videos/sample1.mp4",
      "business": "Cafe Luna",
      "avatar": "assets/images/business1.png",
      "likes": 0,
      "isLiked": false,
      "comments": [],
      "shares": 0,
      "isSaved": false,
      "saves": 0,
    },
    {
      "title": "Tiyatro Gecesi",
      "video": "assets/videos/sample2.mp4",
      "business": "Tiyatro İstanbul",
      "avatar": "assets/images/business2.png",
      "likes": 0,
      "isLiked": false,
      "comments": [],
      "shares": 0,
      "isSaved": false,
      "saves": 0,
    },
  ];

  void _toggleLike(int index) {
    setState(() {
      reels[index]['isLiked'] = !(reels[index]['isLiked'] as bool);
      reels[index]['likes'] += reels[index]['isLiked'] ? 1 : -1;
    });
  }

  void _incrementShare(int index) {
    setState(() {
      reels[index]['shares'] += 1;
    });
  }

  void _toggleSave(int index) {
    setState(() {
      reels[index]['isSaved'] = !(reels[index]['isSaved'] as bool);
      reels[index]['saves'] += reels[index]['isSaved'] ? 1 : -1;
    });
  }

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
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: reels.length,
      itemBuilder: (context, index) {
        final reel = reels[index];
        return Stack(
          children: [
            VideoPlayerWidget(videoUrl: reel["video"] ?? ""),

            // İşletme adı, başlık ve rozet
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
                        Shadow(
                          blurRadius: 12,
                          color: Colors.black,
                          offset: Offset(0, 1),
                        ),
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
                        Shadow(
                          blurRadius: 10,
                          color: Colors.black,
                          offset: Offset(0, 1),
                        ),
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

            // Sağ alt ikonlar + işletme avatarı
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
                  GestureDetector(
                    onTap: () => _toggleLike(index),
                    child: Column(
                      children: [
                        Icon(
                          reel["isLiked"] ? Icons.favorite : Icons.favorite_border,
                          color: reel["isLiked"] ? Colors.red : Colors.white,
                          size: 32,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${reel["likes"]}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => _showComments(context),
                    child: Column(
                      children: [
                        const Icon(Icons.comment, color: Colors.white, size: 32),
                        const SizedBox(height: 4),
                        Text(
                          "${reel["comments"].length}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => _incrementShare(index),
                    child: Column(
                      children: [
                        const Icon(Icons.share, color: Colors.white, size: 32),
                        const SizedBox(height: 4),
                        Text(
                          "${reel["shares"]}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => _toggleSave(index),
                    child: Column(
                      children: [
                        Icon(
                          reel["isSaved"] ? Icons.bookmark : Icons.bookmark_border,
                          color: reel["isSaved"] ? Colors.white : Colors.white60,
                          size: 32,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${reel["saves"]}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
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
