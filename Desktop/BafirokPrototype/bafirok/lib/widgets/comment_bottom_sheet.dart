import 'package:flutter/material.dart';

class CommentBottomSheet extends StatefulWidget {
  const CommentBottomSheet({super.key});

  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  final List<Map<String, String>> comments = [
    {
      "user": "melikegastro",
      "comment": "Çok güzel konsept!",
      "avatar": "assets/images/user1.jpg",
    },
    {
      "user": "mustafakaya",
      "comment": "Cafeye bayıldım 🔥",
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
                      autofocus: true,
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

