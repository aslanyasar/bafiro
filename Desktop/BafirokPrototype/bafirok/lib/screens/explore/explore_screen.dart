import 'package:flutter/material.dart';
import '../../widgets/video_player_widget.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

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
    final List<Map<String, String>> userVideos = [
      {
        "title": "Break Dance Gösterisi",
        "video": "assets/videos/sample3.mp4",
        "user": "can_dancer",
        "avatar": "assets/images/user2.jpg",
      },
      {
        "title": "Mizah Denemesi",
        "video": "assets/videos/sample4.mp4",
        "user": "funny_elif",
        "avatar": "assets/images/user1.jpg",
      },
    ];

    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: userVideos.length,
      itemBuilder: (context, index) {
        final video = userVideos[index];
        return Stack(
          children: [
            VideoPlayerWidget(videoUrl: video["video"] ?? ""),
            
            // Kullanıcı adı, başlık ve rozet
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.04,
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

            // Sağ alt ikonlar + profil
            Positioned(
              right: 16,
              bottom: 100,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(video["avatar"] ?? ""),
                  ),
                  const SizedBox(height: 16),
                  const Icon(Icons.favorite_border, color: Colors.white, size: 32),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => _showComments(context),
                    child: const Icon(Icons.comment, color: Colors.white, size: 32),
                  ),
                  const SizedBox(height: 16),
                  const Icon(Icons.share, color: Colors.white, size: 32),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

// 💬 Yorum Paneli (profil + isimli)
class CommentBottomSheet extends StatefulWidget {
  const CommentBottomSheet({super.key});

  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  final List<Map<String, String>> comments = [
    {
      "user": "elifkara",
      "comment": "Çok komikti 😂",
      "avatar": "assets/images/user1.jpg",
    },
    {
      "user": "can.dancer",
      "comment": "Sen efsanesin 💯",
      "avatar": "assets/images/user2.jpg",
    },
  ];

  final TextEditingController _controller = TextEditingController();

  void _addComment() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        comments.insert(0, {
          "user": "sen.bro",
          "comment": text,
          "avatar": "assets/images/user1.jpg",
        });
        _controller.clear();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 0.9,
      minChildSize: 0.3,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Yorumlar",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundImage: AssetImage(comment["avatar"] ?? ""),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "@${comment["user"]}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  comment["comment"] ?? "",
                                  style: const TextStyle(color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const Divider(color: Colors.grey),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Yorum yaz...",
                        hintStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.grey[850],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onSubmitted: (_) => _addComment(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _addComment,
                    child: const Icon(Icons.send, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

