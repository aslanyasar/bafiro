import 'package:flutter/material.dart';

class UserInfoBlock extends StatelessWidget {
  final String username;
  final String title;

  const UserInfoBlock({
    super.key,
    required this.username,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "@$username",
          style: const TextStyle(color: Colors.white70),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [Shadow(color: Colors.black, blurRadius: 8)],
          ),
        ),
      ],
    );
  }
}

