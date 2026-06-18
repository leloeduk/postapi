import 'package:leloapp/features/posts/data/models/post_model.dart';
import 'package:leloapp/features/posts/data/services/post_api_service.dart';
import 'package:leloapp/features/posts/domain/entities/post.dart';
import 'package:leloapp/features/posts/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostApiService api;
  PostRepositoryImpl(this.api);

  @override
  Future<Post> createPost(Post post) async {
    try {
      final newPost = PostModel(
        id: post.id,
        title: post.title,
        body: post.body,
        name: post.name,
        avatar: post.avatar,
        createdAt: post.createdAt,
      );
      return await api.apiCreatePost(newPost);
    } catch (e) {
      throw Exception("Erreur lors de la création du post: $e");
    }
  }

  @override
  Future<void> deletePost(String id) async {
    try {
      await api.apiDeletePost(id);
    } catch (e) {
      throw Exception("Erreur lors de la suppression du post: $e");
    }
  }

  @override
  Future<Post> updatePost(Post post) async {
    try {
      final newPost = PostModel(
        id: post.id,
        title: post.title,
        body: post.body,
        name: post.name,
        avatar: post.avatar,
        createdAt: post.createdAt,
      );
      return await api.apiUpdatePost(newPost);
    } catch (e) {
      throw Exception("Erreur lors de la mise à jour du post: $e");
    }
  }

  @override
  Future<List<Post>> getAllPosts() async {
    try {
      return await api.apiGetAllPosts();
    } catch (e) {
      print('Erreur dans getAllPosts: $e');
      throw Exception("Impossible de charger les posts: $e");
    }
  }
}
