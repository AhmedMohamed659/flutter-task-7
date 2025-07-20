import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/favorites_service.dart';
import '../widgets/post_card.dart';
import '../widgets/search_delegate.dart';

class FavPostsPage extends StatefulWidget {
  const FavPostsPage({super.key});

  @override
  State<FavPostsPage> createState() => _FavPostsPageState();
}

class _FavPostsPageState extends State<FavPostsPage> {
  List<Post> get favs => FavoritesService.favorites;

  void remove(Post post) {
    setState(() {
      FavoritesService.removeFromFavorites(post);
    });
  }

  void startSearch() {
    showSearch(
      context: context,
      delegate: PostSearchDelegate(favs, remove),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Posts'),
        actions: [
          IconButton(onPressed: startSearch, icon: const Icon(Icons.search))
        ],
      ),
      body: favs.isEmpty
          ? const Center(child: Text('No favorites yet.'))
          : ListView.builder(
              itemCount: favs.length,
              itemBuilder: (context, index) {
                return PostCard(
                  post: favs[index],
                  onFavoriteToggle: () => remove(favs[index]),
                );
              },
            ),
    );
  }
}