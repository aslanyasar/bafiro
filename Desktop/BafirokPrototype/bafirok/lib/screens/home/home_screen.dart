import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../widgets/video_player_widget.dart';
import '../../widgets/comment_bottom_sheet.dart';
import '../../providers/comment_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showComments(BuildContext context, String reelId) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      enableDrag: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => CommentBottomSheet(reelId: reelId),
    );
  }

  void _shareContent(String title) {
    Share.share('Check out this event: $title on Bafirok!');
  }

  void _followUser(String business) {
    print('Takip edildi: @$business');
  }

  @override
  Widget build(BuildContext context) {
    final commentProvider = Provider.of<CommentProvider>(context);
    final List<Map<String, dynamic>> reels = [
      {
        "id": "reel1",
        "title": "Cafe Müzik Gecesi",
        "video": "assets/videos/sample1.mp4",
        "business": "Cafe Luna",
        "avatar": "assets/images/business1.png",
        "likes": 0,
        "isLiked": false,
      },
      {
        "id": "reel2",
        "title": "Tiyatro Gecesi",
        "video": "assets/videos/sample2.mp4",
        "business": "Tiyatro İstanbul",
        "avatar": "assets/images/business2.png",
        "likes": 0,
        "isLiked": false,
      },
    ];

    return SafeArea(
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: reels.length,
        itemBuilder: (context, index) {
          final reel = reels[index];
          final reelId = reel["id"];
          final commentCount = commentProvider.getCommentCount(reelId);
          return Stack(
            clipBehavior: Clip.none,
            children: [
              VideoPlayerWidget(videoUrl: reel["video"] ?? ""),
              Positioned(
                bottom: 16,
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
                    Row(
                      children: [
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
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () => _followUser(reel["business"]),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyanAccent,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text("Takip Et"),
                        ),
                      ],
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
                child: StatefulBuilder(
                  builder: (context, setState) {
                    bool isLiked = reel['isLiked'];
                    int likeCount = reel['likes'];
                    return Column(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(reel["avatar"] ?? ""),
                        ),
                        const SizedBox(height: 16),
                        Column(
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
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () => _showComments(context, reelId),
                          child: Column(
                            children: [
                              const Icon(Icons.comment, color: Colors.white, size: 32),
                              const SizedBox(height: 4),
                              Text(
                                '$commentCount',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () => _shareContent(reel['title']),
                          child: const Column(
                            children: [
                              Icon(Icons.share, color: Colors.white, size: 32),
                              SizedBox(height: 4),
                              Text('0', style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
