import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/post_service.dart';
import '../services/favorites_service.dart';
import '../widgets/post_card.dart';
import '../widgets/search_delegate.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  List<Post> posts = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final data = await PostService.fetchPosts();
    setState(() {
      posts = data;
      loading = false;
    });
  }

  void handleFavorite(Post post) {
    setState(() {
      if (FavoritesService.isFavorite(post)) {
        FavoritesService.removeFromFavorites(post);
      } else {
        FavoritesService.addToFavorites(post);
      }
    });
  }

  void startSearch() {
    showSearch(
      context: context,
      delegate: PostSearchDelegate(posts, handleFavorite),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        actions: [
          IconButton(onPressed: startSearch, icon: const Icon(Icons.search))
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return PostCard(
                  post: posts[index],
                  onFavoriteToggle: () => handleFavorite(posts[index]),
                );
              },
            ),
    );
  }
}