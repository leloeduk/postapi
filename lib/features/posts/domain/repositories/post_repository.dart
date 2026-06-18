import 'package:leloapp/features/posts/domain/entities/post.dart';

abstract class PostRepository {
  // obtenir les données
  Future<List<Post>> getAllPosts();
  Future<Post> createPost(Post post);
  Future<Post> updatePost(Post post);
  Future<void> deletePost(String postId);
}
