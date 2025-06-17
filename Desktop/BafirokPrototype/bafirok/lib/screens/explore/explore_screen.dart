import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../widgets/video_player_widget.dart';
import '../../widgets/comment_bottom_sheet.dart';
import '../../providers/comment_provider.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

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

  void _followUser(String user) {
    print('Takip edildi: @$user');
  }

  @override
  Widget build(BuildContext context) {
    final commentProvider = Provider.of<CommentProvider>(context);
    final List<Map<String, dynamic>> userVideos = [
      {
        "id": "reel3",
        "title": "Break Dance Gösterisi",
        "video": "assets/videos/sample3.mp4",
        "user": "can_dancer",
        "avatar": "assets/images/user2.jpg",
        "likes": 0,
        "isLiked": false,
      },
      {
        "id": "reel4",
        "title": "Mizah Denemesi",
        "video": "assets/videos/sample4.mp4",
        "user": "funny_elif",
        "avatar": "assets/images/user1.jpg",
        "likes": 0,
        "isLiked": false,
      },
    ];

    return SafeArea(
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: userVideos.length,
        itemBuilder: (context, index) {
          final video = userVideos[index];
          final reelId = video["id"];
          final commentCount = commentProvider.getCommentCount(reelId);
          return Stack(
            clipBehavior: Clip.none,
            children: [
              VideoPlayerWidget(videoUrl: video["video"] ?? ""),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video["title"] ?? "",
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
                    Row(
                      children: [
                        Text(
                          "@${video["user"]}",
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
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () => _followUser(video["user"]),
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
                        "Kullanıcı",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.cyanAccent,
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
                    bool isLiked = video['isLiked'];
                    int likeCount = video['likes'];
                    return Column(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(video["avatar"] ?? ""),
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
                                  userVideos[index]['isLiked'] = isLiked;
                                  userVideos[index]['likes'] = likeCount;
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
                          onTap: () => _shareContent(video['title']),
                          child: Column(
                            children: [
                              const Icon(Icons.share, color: Colors.white, size: 32),
                              const SizedBox(height: 4),
                              Text('0', style: const TextStyle(color: Colors.white)),
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
