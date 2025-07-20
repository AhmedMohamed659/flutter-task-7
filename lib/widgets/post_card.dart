import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/favorites_service.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final VoidCallback? onFavoriteToggle;

  const PostCard({
    super.key,
    required this.post,
    this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    final isFav = FavoritesService.isFavorite(post);

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 3,
      child: ListTile(
        title: Text(post.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(post.body),
        trailing: IconButton(
          icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: Colors.red),
          onPressed: onFavoriteToggle,
        ),
      ),
    );
  }
}