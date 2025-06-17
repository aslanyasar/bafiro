import 'package:flutter/material.dart';

class Comment {
  final String user;
  final String comment;
  final String avatar;
  int likes;
  bool isLiked;
  List<Comment> replies;

  Comment({
    required this.user,
    required this.comment,
    required this.avatar,
    this.likes = 0,
    this.isLiked = false,
    this.replies = const [],
  });
}

class CommentProvider extends ChangeNotifier {
  final Map<String, List<Comment>> _commentsByReel = {
    'reel1': [
      Comment(
        user: "elifkara",
        comment: "Harika bir etkinlik! 😂",
        avatar: "assets/images/user1.jpg",
        likes: 5,
        replies: [
          Comment(
            user: "can.dancer",
            comment: "Kesinlikle, bence de! 😎",
            avatar: "assets/images/user2.jpg",
            likes: 2,
          ),
        ],
      ),
    ],
    'reel2': [
      Comment(
        user: "ayse.singer",
        comment: "Bir dahaki sefere ben de ordayım! 🎤",
        avatar: "assets/images/user1.jpg",
        likes: 1,
      ),
    ],
  };

  List<Comment> getComments(String reelId) {
    return _commentsByReel[reelId] ?? [];
  }

  int getCommentCount(String reelId) {
    return _commentsByReel[reelId]?.length ?? 0;
  }

  void addComment(String reelId, String text) {
    _commentsByReel.putIfAbsent(reelId, () => []);
    _commentsByReel[reelId]!.insert(
      0,
      Comment(
        user: "sen.bro",
        comment: text,
        avatar: "assets/images/user1.jpg",
      ),
    );
    notifyListeners();
  }

  void addReply(String reelId, int index, String text) {
    if (_commentsByReel[reelId] != null) {
      _commentsByReel[reelId]![index].replies = [
        ..._commentsByReel[reelId]![index].replies,
        Comment(
          user: "sen.bro",
          comment: text,
          avatar: "assets/images/user1.jpg",
        ),
      ];
      notifyListeners();
    }
  }

  void toggleLike(String reelId, int index) {
    if (_commentsByReel[reelId] != null) {
      _commentsByReel[reelId]![index].isLiked = !_commentsByReel[reelId]![index].isLiked;
      _commentsByReel[reelId]![index].likes += _commentsByReel[reelId]![index].isLiked ? 1 : -1;
      notifyListeners();
    }
  }

  void toggleReplyLike(String reelId, int commentIndex, int replyIndex) {
    if (_commentsByReel[reelId] != null) {
      _commentsByReel[reelId]![commentIndex].replies[replyIndex].isLiked =
          !_commentsByReel[reelId]![commentIndex].replies[replyIndex].isLiked;
      _commentsByReel[reelId]![commentIndex].replies[replyIndex].likes +=
          _commentsByReel[reelId]![commentIndex].replies[replyIndex].isLiked ? 1 : -1;
      notifyListeners();
    }
  }
}
