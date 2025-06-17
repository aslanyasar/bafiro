import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/comment_provider.dart';

class CommentBottomSheet extends StatefulWidget {
  final String reelId;
  const CommentBottomSheet({super.key, required this.reelId});

  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  final TextEditingController _controller = TextEditingController();
  int? replyToIndex;
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submitComment(BuildContext context) {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      final commentProvider = Provider.of<CommentProvider>(context, listen: false);
      if (replyToIndex != null) {
        commentProvider.addReply(widget.reelId, replyToIndex!, text);
      } else {
        commentProvider.addComment(widget.reelId, text);
      }
      _controller.clear();
      setState(() {
        replyToIndex = null;
      });
      _focusNode.unfocus();
    }
  }

  void _handleReply(int index) {
    setState(() {
      replyToIndex = index;
    });
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final commentProvider = Provider.of<CommentProvider>(context);
    final comments = commentProvider.getComments(widget.reelId);

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 0.9,
      minChildSize: 0.3,
      snap: true,
      snapSizes: const [0.3, 0.6, 0.9],
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "Yorumlar",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(comment.avatar),
                                radius: 18,
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
                                          "@${comment.user}",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "${comment.likes}",
                                              style: const TextStyle(
                                                color: Colors.black54,
                                                fontSize: 12,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            GestureDetector(
                                              onTap: () {
                                                commentProvider.toggleLike(widget.reelId, index);
                                              },
                                              child: Icon(
                                                comment.isLiked ? Icons.favorite : Icons.favorite_border,
                                                color: comment.isLiked ? Colors.red : Colors.black54,
                                                size: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      comment.comment,
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    GestureDetector(
                                      onTap: () => _handleReply(index),
                                      child: const Text(
                                        "Yanıtla",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          if (comment.replies.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(left: 48),
                              child: Column(
                                children: comment.replies.asMap().entries.map((entry) {
                                  final replyIndex = entry.key;
                                  final reply = entry.value;
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 6),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: AssetImage(reply.avatar),
                                          radius: 14,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    "@${reply.user}",
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "${reply.likes}",
                                                        style: const TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 11,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 4),
                                                      GestureDetector(
                                                        onTap: () {
                                                          commentProvider.toggleReplyLike(widget.reelId, index, replyIndex);
                                                        },
                                                        child: Icon(
                                                          reply.isLiked ? Icons.favorite : Icons.favorite_border,
                                                          color: reply.isLiked ? Colors.red : Colors.black54,
                                                          size: 16,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                reply.comment,
                                                style: const TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage("assets/images/user1.jpg"),
                      radius: 16,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: replyToIndex != null
                              ? "@${comments[replyToIndex!].user} kullanıcısına yanıt yaz..."
                              : "Yorum yaz...",
                          hintStyle: const TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        onSubmitted: (_) => _submitComment(context),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => _submitComment(context),
                      child: const Icon(Icons.send, color: Colors.blue, size: 24),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
