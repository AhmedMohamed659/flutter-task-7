import '../models/post.dart';

class FavoritesService {
  static final List<Post> _favoritePosts = [];

  static List<Post> get favorites => _favoritePosts;

  static void addToFavorites(Post post) {
    if (!_favoritePosts.any((p) => p.id == post.id)) {
      _favoritePosts.add(post);
    }
  }

  static void removeFromFavorites(Post post) {
    _favoritePosts.removeWhere((p) => p.id == post.id);
  }

  static bool isFavorite(Post post) {
    return _favoritePosts.any((p) => p.id == post.id);
  }

  static int count() => _favoritePosts.length;
}