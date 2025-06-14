import 'package:flutter/material.dart';

class ActionBar extends StatelessWidget {
  final Map<String, dynamic> reel;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onShare;
  final VoidCallback onSave;

  const ActionBar({
    super.key,
    required this.reel,
    required this.onLike,
    required this.onComment,
    required this.onShare,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(reel['avatar']),
        ),
        const SizedBox(height: 12),

        IconButton(
          icon: Icon(
            Icons.favorite,
            color: reel['isLiked'] == true ? Colors.red : Colors.white,
          ),
          onPressed: onLike,
        ),
        Text("${reel['likes'] ?? 0}", style: const TextStyle(color: Colors.white)),

        const SizedBox(height: 8),
        IconButton(
          icon: const Icon(Icons.comment, color: Colors.white),
          onPressed: onComment,
        ),
        Text("${(reel['comments'] as List).length}", style: const TextStyle(color: Colors.white70)),

        const SizedBox(height: 8),
        IconButton(
          icon: const Icon(Icons.share, color: Colors.white),
          onPressed: onShare,
        ),
        const Text("2", style: TextStyle(color: Colors.white70)),

        const SizedBox(height: 8),
        IconButton(
          icon: Icon(
            reel['isSaved'] == true ? Icons.bookmark : Icons.bookmark_border,
            color: reel['isSaved'] == true ? Colors.white : Colors.white60,
          ),
          onPressed: onSave,
        ),
        Text("${reel['saves'] ?? 0}", style: const TextStyle(color: Colors.white70)),
      ],
    );
  }
}

