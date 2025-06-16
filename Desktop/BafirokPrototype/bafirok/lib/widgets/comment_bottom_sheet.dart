import 'package:flutter/material.dart';

class CommentBottomSheet extends StatefulWidget {
  const CommentBottomSheet({super.key});

  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  final List<Map<String, dynamic>> comments = [
    {
      "user": "melikegastro",
      "comment": "Çok güzel konsept!",
      "avatar": "assets/images/user1.jpg",
      "likes": 2,
      "isLiked": false,
    },
    {
      "user": "mustafakaya",
      "comment": "Cafeye bayıldım 🔥",
      "avatar": "assets/images/user2.jpg",
      "likes": 1,
      "isLiked": false,
    },
  ];

  final TextEditingController _controller = TextEditingController();
  int? replyToIndex;

  void _addComment() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        comments.insert(0, {
          "user": "sen.bro",
          "comment": text,
          "avatar": "assets/images/user1.jpg",
          "likes": 0,
          "isLiked": false,
        });
        _controller.clear();
        replyToIndex = null;
      });
    }
  }

  void _toggleLike(int index) {
    setState(() {
      comments[index]['isLiked'] = !comments[index]['isLiked'];
      if (comments[index]['isLiked']) {
        comments[index]['likes']++;
      } else {
        comments[index]['likes']--;
      }
    });
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
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Yorumlar",
                style: TextStyle(
                  color: Colors.black,
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "@${comment["user"]}",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${comment['likes']}",
                                          style: const TextStyle(color: Colors.black87),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            comment['isLiked']
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: comment['isLiked'] ? Colors.red : Colors.black45,
                                            size: 20,
                                          ),
                                          onPressed: () => _toggleLike(index),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  comment["comment"] ?? "",
                                  style: const TextStyle(color: Colors.black87),
                                ),
                                const SizedBox(height: 4),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      replyToIndex = index;
                                    });
                                  },
                                  child: const Text(
                                    "Yanıtla",
                                    style: TextStyle(color: Colors.grey, fontSize: 12),
                                  ),
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
              if (replyToIndex != null)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      "@${comments[replyToIndex!]['user']} kullanıcısına yanıt yazılıyor...",
                      style: const TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                  ),
                ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      autofocus: true,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "Yorum yaz...",
                        hintStyle: const TextStyle(color: Colors.black45),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        suffixIcon: const Icon(Icons.emoji_emotions),
                      ),
                      onSubmitted: (_) => _addComment(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _addComment,
                    child: const Icon(Icons.send, color: Colors.black),
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
