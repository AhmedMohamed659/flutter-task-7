import 'package:flutter/material.dart';
import '../models/post.dart';
import 'post_card.dart';

class PostSearchDelegate extends SearchDelegate {
  final List<Post> posts;
  final Function(Post) onToggle;

  PostSearchDelegate(this.posts, this.onToggle);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return BackButton(onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    final result = posts
        .where((post) => post.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (context, index) {
        return PostCard(
          post: result[index],
          onFavoriteToggle: () => onToggle(result[index]),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}